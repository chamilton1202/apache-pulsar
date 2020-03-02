###################################################################################################################
#This Dockerfile is used as a wrapper for the Apache Pulsar Dashboard Image and properly assign to a Non-Root user.
#The assumption is that Apache Pulsar images will maintain the same directory structure and root user.
#This container image is intended to be safer for Kubernetes Platform deployments such as Red Hat OpenShift by using a Non-Root user.
#Created By Chad J. Hamilton February 2020
#Enjoy!
###################################################################################################################

FROM apachepulsar/pulsar-dashboard:latest

#Verify the Pulsar image is cleaned up to save space
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

#Set Permissions on /pulsar to be anyuid and root group
ENV APP_ROOT=/pulsar
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}
COPY bin/ ${APP_ROOT}/bin/
RUN chmod -R u+x ${APP_ROOT} && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd

#Switch the user to be USER 10001
USER 10001
WORKDIR ${APP_ROOT}

#User recognition at runtime w/arbitrary uid
ENTRYPOINT [ "uid_entrypoint" ]
CMD run
