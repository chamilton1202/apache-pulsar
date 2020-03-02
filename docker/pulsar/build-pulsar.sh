#!/bin/bash

#Setup Variables
VERSION=2.5.0
CONTAINER_IMAGE_REPO=chamilton614
CONTAINER_IMAGE=pulsar

#Check Variables
if [ -z ${CONTAINER_IMAGE_REPO} ] || [ -z ${CONTAINER_IMAGE} ]; then
    echo 'Missing Required values.  Exiting.'
    exit
fi

#Download the Apache Pulsar Tarball
echo 'Download the Apache Pulsar Binary Tarball'
bin/get-apache-pulsar-tar.sh

#Set the PULSAR_TARBALL
PULSAR_TARBALL=$(ls apache-pulsar-*-bin.tar.gz)
echo 'PULSAR_TARBALL='${PULSAR_TARBALL}

#Extract the Apache Pulsar Source Tarball
echo 'Extract the Apache Pulsar Source'
tar xfz $(ls apache-pulsar-*-src.tar.gz)

#Copy Pulsar Docker scripts
echo 'Get the Pulsar Scripts'
mkdir scripts && cp $(ls -d apache-pulsar-*/)docker/${CONTAINER_IMAGE}/scripts/*.* scripts/

#Get the Pulsar Python Client and C++ Client from Apache Pulsar Image
echo 'Get the Pulsar Python and C++ Clients'
mkdir target && bin/get-apache-pulsar-clients.sh

#Podman build the Custom Apache Pulsar Image
echo 'Build the Custom Apache Pulsar Image -' ${CONTAINER_IMAGE_REPO}/${CONTAINER_IMAGE}
podman build --build-arg PULSAR_TARBALL=${PULSAR_TARBALL} -t ${CONTAINER_IMAGE_REPO}/${CONTAINER_IMAGE} .

#Cleanup
echo 'Cleaning up after the Build'
rm -rf scripts/
rm -rf apache-pulsar-*/
rm -rf target/
rm -f apache-pulsar*.tar.gz

echo 'Finished Building the Custom Apache Pulsar Image'
read p