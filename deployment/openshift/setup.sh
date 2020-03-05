#!/bin/bash

PROJECT=$1
QUAY_USER=$2
QUAY_PASSWORD=$3

#Check on passed in parameters
if [ -z ${PROJECT} ] || [ -z ${QUAY_USER} ] || [ -z ${QUAY_PASSWORD} ]; then
	echo ''
	echo 'Script requires PROJECT QUAY_USER QUAY_PASSWORD to be passed in'
	echo 'e.g. setup.sh connected-workspaces-poc quay-user quay-password'
	echo ''
	exit
fi

#Create Project
oc new-project ${PROJECT}

#Create Quay Secret
oc create secret docker-registry quay-secret \
    --docker-server=quay.io \
    --docker-username=${QUAY_USER} \
    --docker-password=${QUAY_PASSWORD} \
    --docker-email=None

#Link Quay Secret to Default
oc secrets link default secret/quay-secret --for=pull

#Link Quay Secret to Builder
oc secrets link builder secret/quay-secret

#Deploy Zookeeper App
oc apply -f zookeeper.yaml

#Create Cluster-Metadata Job
oc apply -f cluster-metadata.yaml

#Deploy Bookeeper App
oc apply -f bookie.yaml

#Deploy Broker App
oc apply -f broker.yaml

#Deploy Admin Pod
oc apply -f admin.yaml

#Deploy Proxy App
oc apply -f proxy.yaml

#Expose the Proxy Service
oc expose svc/proxy

