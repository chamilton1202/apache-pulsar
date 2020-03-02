#!/bin/bash

VERSION=2.5.0

#Launch Dummy apachepulsar/pulsar-all
echo 'Remove Previous pulsar-all container if it exists'
podman rm pulsar-all
echo 'Run pulsar-all container'
podman run --name pulsar-all apachepulsar/pulsar-all

#Get Python Client
echo 'Copy the Pulsar Python Client'
podman cp pulsar-all:/pulsar/pulsar-client target/
mv target/pulsar-client target/python-client

#Get C++ Client
echo 'Copy the Pulsar C++ Client'
podman cp pulsar-all:/pulsar/cpp-client target/