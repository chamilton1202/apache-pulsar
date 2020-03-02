###################################################################################################################
#This Dockerfile is used as a wrapper for the Apache Pulsar All Image and properly assign to a Non-Root user.
#The assumption is that Apache Pulsar images will maintain the same directory structure and root user.
#This container image is intended to be safer for Kubernetes Platform deployments such as Red Hat OpenShift by using a Non-Root user.
#Created By Chad J. Hamilton February 2020
#Enjoy!
###################################################################################################################
FROM busybox as pulsar-all

ARG PULSAR_IO_DIR
ARG PULSAR_OFFLOADER_TARBALL

COPY ${PULSAR_IO_DIR} /connectors

ADD ${PULSAR_OFFLOADER_TARBALL} /
RUN mv /apache-pulsar-offloaders-*/offloaders /offloaders

#Use Custom Apache Pulsar Base Image
FROM chamilton614/pulsar:latest

#Reset User to root
USER root

COPY --from=pulsar-all /connectors /pulsar/connectors
COPY --from=pulsar-all /offloaders /pulsar/offloaders

ENV APP_ROOT=/pulsar
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}

#Switch the user to be USER 10001
USER 10001

WORKDIR ${APP_ROOT}

#User recognition at runtime w/arbitrary uid
#ENTRYPOINT [ "uid_entrypoint" ]
#CMD run
