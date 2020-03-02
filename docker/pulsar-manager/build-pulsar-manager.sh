#!/bin/bash

#Setup Variables
BUILD_DATE=$(date)
VCS_REF=branch-0.1.0
VERSION=0.1.0
CONTAINER_IMAGE_REPO=chamilton614
CONTAINER_IMAGE=pulsar-manager

#Check Variables
if [ -z ${BUILD_DATE} ] || [ -z ${VCS_REF} ] || [ -z ${VERSION} ] ||
    [ -z ${CONTAINER_IMAGE_REPO} ] || [ -z ${CONTAINER_IMAGE} ]; then
    echo 'Missing Required values.  Exiting.'
    exit
fi

#Download the Apache Pulsar Manager Tarball
echo 'Download the Apache Pulsar Manager Binary Tarball'
bin/get-apache-pulsar-manager-tar.sh

#Output the BUILD_DATE
echo 'BUILD_DATE='${BUILD_DATE}

#Output the VCS_REF
echo 'VCS_REF='${VCS_REF}

#Output the VERSION
echo 'VERSION='${VERSION}

#Set the PULSAR_TARBALL
PULSAR_TARBALL=$(ls apache-pulsar-manager-*-bin.tar.gz)
echo 'PULSAR_TARBALL='${PULSAR_TARBALL}

#Extract the Apache Pulsar Manager Bin Tarball
echo 'Extract the Apache Pulsar Manager Bin'
mkdir bin-tar && tar xfz $(ls apache-pulsar-manager-*-bin.tar.gz) -C bin-tar/
mkdir -p bin-tar/pulsar-manager/extracted && tar xf bin-tar/pulsar-manager/pulsar-manager.tar -C bin-tar/pulsar-manager/extracted/

#Extract the Apache Pulsar Manager Source Tarball
echo 'Extract the Apache Pulsar Manager Source'
mkdir src-tar && tar xfz $(ls apache-pulsar-manager-*-src.tar.gz) -C src-tar/

#Podman build the Custom Apache Pulsar Image
echo 'Build the Custom Apache Pulsar Image -' ${CONTAINER_IMAGE_REPO}/${CONTAINER_IMAGE}
podman build --layers --force-rm -t ${CONTAINER_IMAGE_REPO}/${CONTAINER_IMAGE} .

#podman build --build-arg BUILD_DATE=${BUILD_DATE} --build-arg VCS_REF=${VCS_REF} --build-arg VERSION=${VERSION} \
#    --layers --force-rm -t ${CONTAINER_IMAGE_REPO}/${CONTAINER_IMAGE} .

#podman build --layers --force-rm -t ${CONTAINER_IMAGE_REPO}/${CONTAINER_IMAGE} .

#Cleanup
echo 'Cleaning up after the Build'
rm -rf bin-tar/
rm -rf src-tar/
#rm -f apache-pulsar*.tar.gz

echo 'Finished Building the Custom Apache Pulsar Image'
read p