#!/bin/bash

#Setup Variables
USERNAME=chamilton614
PASSWORD=
LOCAL_REPOSITORY=chamilton614/pulsar:latest
REMOTE_REPOSITORY_LOCATION=quay.io
REMOTE_REPOSITORY_URL_PREFIX=docker://
REMOTE_REPOSITORY=${REMOTE_REPOSITORY_LOCATION}/${LOCAL_REPOSITORY}

#Login to Remote Repository
echo 'Login to Remote Repository - [User]:' ${USERNAME} '[Repository Location]:' ${REMOTE_REPOSITORY_LOCATION}
podman login -u ${USERNAME} ${REMOTE_REPOSITORY_LOCATION}

#Push Container Image to Remote Repository
echo 'Push Container Image to Remote Repository - [Local Image]:' ${LOCAL_REPOSITORY} '[Remote Image]:' ${REMOTE_REPOSITORY_URL_PREFIX}${REMOTE_REPOSITORY}
podman push ${LOCAL_REPOSITORY} ${REMOTE_REPOSITORY_URL_PREFIX}${REMOTE_REPOSITORY}

