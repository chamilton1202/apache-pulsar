## Deployment Steps for the Custom Apache Pulsar Container Images on OpenShift
These deployment steps are documented for an OpenShift deployment but they could also be used for any Kubernetes Platform just by replacing "oc" with "kubectl".

### Create the Pulsar Project
`oc new-project apache-pulsar`

### Create the Quay Container Image Pull Secret
`oc create secret docker-registry quay-secret \`
    `--docker-server=quay.io \`
    `--docker-username=<Quay Username> \`
    `--docker-password=<Quay Password> \`
    `--docker-email=None`

### Link the Secret to the Default Service Account
`oc secrets link default secret/quay-secret --for=pull`

### Link the Secret to the Builder Service Account
`oc secrets link builder secret/quay-secret`

### Deploy the Zookeeper Application
`oc apply -f zookeeper.yaml`

### Create the Cluster-Metadata Job
`oc apply -f cluster-metadata.yaml`

### Deploy the Bookeeper Application
`oc apply -f bookie.yaml`

### Deploy the Broker Application
`oc apply -f broker.yaml`

### Deploy the Proxy Application
`oc apply -f proxy.yaml`

### Deploy the Admin Pod to allow the use of the Pulsar-Admin Client
`oc apply -f admin.yaml`

### Expose the Proxy Service
`oc expose svc/proxy`

### Deploy the Pulsar Manager Application
`TBA for Pulsar Manager`

## Configure Pulsar Cluster
Using the Pulsar Admin pod, namespaces and tenants can be created to get the Cluster up and going.

### Create an Alias for the pulsar-admin tool using the Pulsar Admin Pod
`alias pulsar-admin='oc exec pulsar-admin -it -- bin/pulsar-admin'`

### Create an Alias for the pulsar-perf tool using the Pulsar Admin Pod
`alias pulsar-perf='oc exec pulsar-admin -it -- bin/pulsar-perf'`

### Create a Tenant called apria
`pulsar-admin tenants create apria --admin-roles admin --allowed-clusters local`

### Create a Namespace under the Tenant apria
`pulsar-admin namespaces create apria/ns`

### Get list of Tenants
`pulsar-admin tenants list`

### Get list of Namespaces for a given Tenant
`pulsar-admin namespaces list apria`

