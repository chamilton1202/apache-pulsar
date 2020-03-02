## Deployment Steps for the Custom Apache Pulsar Container Images on OpenShift
These deployment steps are documented for an OpenShift deployment but they could also be used for any Kubernetes Platform just by replacing "oc" with "kubectl".

### Create the Pulsar Project
`oc new-project apache-pulsar`

### Create the Quay Container Image Pull Secret
```oc create secret docker-registry quay-secret \
    `--docker-server=quay.io \
    --docker-username=<Quay Username> \
    --docker-password=<Quay Password> \
    --docker-email=None```

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

### Create a Tenant called Ten
`pulsar-admin tenants create Ten --admin-roles admin --allowed-clusters local`

### Create a Namespace under the Tenant Ten
`pulsar-admin namespaces create Ten/ns`

### Get list of Tenants
`pulsar-admin tenants list`

### Get list of Namespaces for a given Tenant
`pulsar-admin namespaces list Ten`

## Performance Test with Pulsar
This test requires 3 Remote connected sessions with 1 for a Producer of messages, 1 as a Consumer of the messages and 1 to review results/stats

### Produce 10,000 messages per second that run continuously
Using the 1st Remote Session
`pulsar-perf produce persistent://public/default/my-topic --rate 10000`

### Consume the 10,000 messages and run continuously
Using the 2nd Remote Session
`pulsar-perf consume persistent://public/default/my-topic --subscriber-name my-subscription-name`

### View the Statistics for the Topic created above
Using the 3rd Remote Session
`pulsar-admin persistent stats persistent://public/default/my-topic`











