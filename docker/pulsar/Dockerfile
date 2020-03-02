###################################################################################################################
#This Dockerfile is used as a wrapper for the Apache Pulsar Base Image and properly assign to a Non-Root user.
#The assumption is that Apache Pulsar images will maintain the same directory structure and root user.
#This container image is intended to be safer for Kubernetes Platform deployments such as Red Hat OpenShift by using a Non-Root user.
#Created By Chad J. Hamilton February 2020
#Enjoy!
###################################################################################################################
# First create a stage with just the Pulsar tarball and scripts
FROM busybox as pulsar

ARG PULSAR_TARBALL

ADD ${PULSAR_TARBALL} /
RUN mv /apache-pulsar-* /pulsar

COPY scripts /pulsar/bin

### Create 2nd stage from OpenJDK image
### and add Python dependencies (for Pulsar functions)

FROM openjdk:8-jdk-slim
COPY --from=pulsar /pulsar /pulsar

COPY target/python-client/ /pulsar/pulsar-client
COPY target/cpp-client/ /pulsar/cpp-client

# Install some utilities
RUN apt-get update \
     && apt-get install -y netcat dnsutils less procps iputils-ping \
                 python2.7 python-setuptools python-yaml python-kazoo \
                 python3.7 python3-setuptools python3-yaml python3-kazoo \
                 libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev \
                 curl \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

RUN  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
     python2.7 get-pip.py && \
     python3.7 get-pip.py && \
     /pulsar/bin/install-pulsar-client-27.sh && \
     /pulsar/bin/install-pulsar-client-37.sh && \
     echo networkaddress.cache.ttl=1 >> $JAVA_HOME/jre/lib/security/java.security

RUN apt-get update \
     && apt install -y /pulsar/cpp-client/*.deb \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/*

#Set Permissions on /pulsar to be anyuid and root group
ENV APP_ROOT=/pulsar
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}
COPY bin/ ${APP_ROOT}/bin/
RUN useradd -u 10001 -r -g 0 -d ${APP_ROOT} -s /sbin/nologin -c "Default user" default && \
    chmod -R u+x ${APP_ROOT} && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd

#Switch the user to be USER 10001
USER 10001

WORKDIR ${APP_ROOT}

VOLUME  ["/pulsar/conf", "/pulsar/data"]

ENV PULSAR_ROOT_LOGGER=INFO,CONSOLE

#User recognition at runtime w/arbitrary uid
#ENTRYPOINT [ "uid_entrypoint" ]
#CMD run