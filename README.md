# Apache Pulsar
This is the Git Repository for Building and Deploying a Custom Apache Pulsar container images on a Kubernetes Platform.  The key difference with these builds and deployments are that each container image has been updated to use a Non-Root user.  This helps significantly reduce the risk of a Security issue and follows Best practices for containerizing applications.  

The Repository is intended to be used for deploying these modified container images into a Kubernetes Platform.  While you can build the Containers and run them independently the goal was for them to be packaged with Kubernetes or even easier within OpenShift.


