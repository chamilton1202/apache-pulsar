## Deployment Steps for the Custom Apache Pulsar Container Images on Kubernetes
`oc new-project apache-pulsar`

`oc create secret docker-registry quay-secret \`
    `--docker-server=quay.io \`
    `--docker-username=<Quay Username> \`
    `--docker-password=<Quay Password> \`
    `--docker-email=None`

`oc secrets link default secret/quay-secret --for=pull`

`oc secrets link builder secret/quay-secret`

`oc apply -f zookeeper.yaml`

`oc apply -f cluster-metadata.yaml`

`oc apply -f bookie.yaml`

`oc apply -f broker.yaml`

`oc apply -f proxy.yaml`

`oc apply -f admin.yaml`

`oc expose svc/proxy`