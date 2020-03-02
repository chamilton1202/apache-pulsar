###################################################################################################################
#This Dockerfile is used as a wrapper for the Apache Pulsar Manager Image and properly assign to a Non-Root user.
#The assumption is that Apache Pulsar images will maintain the same directory structure and root user.
#This container image is intended to be safer for Kubernetes Platform deployments such as Red Hat OpenShift by using a Non-Root user.
#Created By Chad J. Hamilton February 2020
#Enjoy!
###################################################################################################################

FROM openjdk:8-jre-alpine

RUN apk update && \
    apk add nginx && \
    apk add supervisor && \
    apk add postgresql && \
    rm  -rf /tmp/* && \
    rm /var/cache/apk/* && \
    mkdir -p /run/nginx

WORKDIR /pulsar-manager

COPY bin-tar/pulsar-manager/extracted/ .
COPY config/etc/ /etc/
COPY config/default.conf /etc/nginx/conf.d/
COPY config/nginx.conf /etc/nginx/
COPY config/startup/ /pulsar-manager/
COPY bin-tar/pulsar-manager/dist /usr/share/nginx/html/

#Set Permissions on /pulsar-manager to be anyuid and root group
ENV APP_ROOT=/pulsar-manager
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}
COPY bin/ ${APP_ROOT}/bin/
RUN mkdir -p /run/postgresql && \
    mkdir -p /data && \
    addgroup pulsar && \
    adduser -u 10001 -G root -D -h ${APP_ROOT} -s /bin/ash pulsar && \
    addgroup pulsar pulsar && \
    addgroup root pulsar && \
    addgroup pulsar nginx && \
    addgroup pulsar postgres && \
    chmod -R u+x ${APP_ROOT} && \
    chgrp -R root ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd && \
    chown -R pulsar:root /run/nginx/ && \
    chown -R pulsar:root /run/postgresql/ && \
    chown -R pulsar:root /run/secrets/ && \
    chown -R pulsar:root /data && \
    chown -R pulsar:root /var/lib/nginx && \
    chown -R pulsar:root /var/lib/nginx/logs && \
    chown -R pulsar:root /var/lib/nginx/tmp && \
    chown -R pulsar:root /var/lib/postgresql && \
    chown -R pulsar:root /var/tmp/nginx && \
    chown pulsar:root /pulsar-manager/init_db.sql && \
    chown pulsar:root /pulsar-manager/startup.sh && \
    chmod 777 /data && \
    chmod 775 /var/lib/nginx/ && \
    chmod 775 /var/lib/nginx/logs && \
    chmod 775 /var/lib/nginx/tmp && \
    chmod 775 /var/lib/postgresql && \
    chmod 775 /var/tmp/nginx && \
    chmod 777 /etc/nginx/nginx.conf

#Switch the user to be USER 10001
USER 10001
WORKDIR ${APP_ROOT}

ENTRYPOINT [ "/pulsar-manager/entrypoint.sh" ]
#ENTRYPOINT [ "uid_entrypoint" ]
#CMD run
