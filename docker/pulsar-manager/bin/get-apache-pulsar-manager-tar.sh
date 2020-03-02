#!/bin/bash

VERSION=0.1.0

#Check if Download is needed
if [ ! -e apache-pulsar-manager-${VERSION}-bin.tar.gz ]; then
    #Download the Apache Pulsar Manager Binary
    wget https://archive.apache.org/dist/pulsar/pulsar-manager/pulsar-manager-${VERSION}/apache-pulsar-manager-${VERSION}-bin.tar.gz
fi

#Check if Download is needed
if [ ! -e apache-pulsar-manager-${VERSION}-src.tar.gz ]; then
    #Download the Apache Pulsar Manager Source
    wget https://archive.apache.org/dist/pulsar/pulsar-manager/pulsar-manager-${VERSION}/apache-pulsar-manager-${VERSION}-src.tar.gz
fi