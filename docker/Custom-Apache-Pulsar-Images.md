##Custom Apache Pulsar Images
All of the Pulsar images are set to run as root, which is a bad practice for containers.  They are multi-stage docker images that build upon a base Pulsar image.  The other issue is the base Pulsar image defines a volume in the main application directory which causes issues for downstream images
that are trying to set the container user as a non-root and be able to run scripts.
The solution is to build Pulsar from the provided Docker files and remove unnecessary steps in those files to create a Kubernetes compliant application running as a non-root user.  This also helps avoid leveraging a Security Context Contstraint (SCC) and provides a cleaner deployment.

##Build Custom Pulsar Base Image
1. Clone the Apache Pulsar Git Repository https://github.com/apache/pulsar.git
2. cd to docker/pulsar
3. Open the Dockerfile
4. Edit the following sections
    - 

##Update Downstream Pulsar Images


