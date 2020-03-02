#!/bin/bash

VERSION=2.5.0

#Check if Download is needed
if [ ! -e apache-pulsar-${VERSION}-bin.tar.gz ]; then
    #Download the Apache Pulsar Binary
    wget https://archive.apache.org/dist/pulsar/pulsar-${VERSION}/apache-pulsar-${VERSION}-bin.tar.gz
fi

#Check if Download is needed
if [ ! -e apache-pulsar-${VERSION}-src.tar.gz ]; then
    #Download the Apache Pulsar Source
    wget https://archive.apache.org/dist/pulsar/pulsar-${VERSION}/apache-pulsar-${VERSION}-src.tar.gz
fi
