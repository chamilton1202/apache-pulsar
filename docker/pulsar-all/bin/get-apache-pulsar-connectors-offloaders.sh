#!/bin/bash

VERSION=2.5.0

#Check if Download is needed
if [ ! -e apache-pulsar-offloaders-${VERSION}-bin.tar.gz ]; then
    #Downlaod the Apache Pulsar Offloaders Binary
    wget https://archive.apache.org/dist/pulsar/pulsar-${VERSION}/apache-pulsar-offloaders-${VERSION}-bin.tar.gz
fi

#Launch Dummy apachepulsar/pulsar-all
echo 'Remove Previous pulsar-all container if it exists'
podman rm pulsar-all
echo 'Run pulsar-all container'
podman run --name pulsar-all apachepulsar/pulsar-all

#Get Connectors
echo 'Copy the Pulsar Connectors'
podman cp pulsar-all:/pulsar/connectors .

#Get Offloaders
#echo 'Copy the Pulsar Offloaders'
#podman cp pulsar-all:/pulsar/offloaders .
