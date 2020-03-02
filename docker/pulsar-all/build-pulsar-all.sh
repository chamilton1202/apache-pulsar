#!/bin/bash

#Setup Variables
VERSION=2.5.0
CONTAINER_IMAGE_REPO=chamilton614
CONTAINER_IMAGE=pulsar-all

#Check Variables
if [ -z ${CONTAINER_IMAGE_REPO} ] || [ -z ${CONTAINER_IMAGE} ]; then
    echo 'Missing Required values.  Exiting.'
    exit
fi

#Download the Apache Pulsar Connectors and Offloaders
echo 'Download the Apache Pulsar Connectors and Offloaders'
bin/get-apache-pulsar-connectors-offloaders.sh

#Set the PULSAR_IO_DIR
PULSAR_IO_DIR=connectors
echo 'PULSAR_IO_DIR='${PULSAR_IO_DIR}

#Set the PULSAR_OFFLOADER_TARBALL
PULSAR_OFFLOADER_TARBALL=$(ls apache-pulsar-*-bin.tar.gz)
echo 'PULSAR_OFFLOADER_TARBALL='${PULSAR_OFFLOADER_TARBALL}

#Podman build the Custom Apache Pulsar-all Image
echo 'Build the Custom Apache Pulsar-all Image -' ${CONTAINER_IMAGE_REPO}/${CONTAINER_IMAGE}
podman build --layers --force-rm --build-arg PULSAR_IO_DIR=${PULSAR_IO_DIR} --build-arg PULSAR_OFFLOADER_TARBALL=${PULSAR_OFFLOADER_TARBALL} -t ${CONTAINER_IMAGE_REPO}/${CONTAINER_IMAGE} .

#Cleanup
echo 'Cleaning up after the Build'
rm -rf connectors/
rm -f apache-pulsar*.tar.gz

echo 'Finished Building the Custom Apache Pulsar-all Image'
read p