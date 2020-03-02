#!/bin/sh

echo 'Starting PostGreSQL Server'

# addgroup pulsar
# adduser --disabled-password --ingroup pulsar pulsar
# mkdir -p /run/postgresql
# chown -R pulsar:pulsar /run/postgresql/
# chown -R pulsar:pulsar /data
# chown pulsar:pulsar /pulsar-manager/init_db.sql
# chmod 750 /data

#su - pulsar -s /bin/sh /pulsar-manager/startup.sh
/pulsar-manager/startup.sh

echo 'Starting Pulsar Manager Front end'
nginx

echo 'Starting Pulsar Manager Back end'

touch /pulsar-manager/supervisor.sock
chmod 777 /pulsar-manager/supervisor.sock

if [[ -n "$JWT_TOKEN" ]] && [[ -n "$PUBLIC_KEY" ]] && [[ -n "$PRIVATE_KEY" ]]
then
  echo "Use public key and private key to init JWT."
  supervisord -c /etc/supervisord-private-key.conf -n
elif [[ -n "$JWT_TOKEN" ]] && [[ -n "$SECRET_KEY" ]]
then
  echo "Use secret key to init JWT."
  supervisord -c /etc/supervisord-secret-key.conf -n
elif [[ -n "$JWT_TOKEN" ]]
then
  echo "Enable JWT auth."
  supervisord -c /etc/supervisord-token.conf -n
elif [[ -n "$SPRING_CONFIGURATION_FILE" ]]
then
  echo "Start Pulsar Manager by specifying a configuration file."
  supervisord -c /etc/supervisord-configuration-file.conf -n
else
  echo "Start servie no enable JWT."
  supervisord -c /etc/supervisord.conf -n
fi
