
### ZooKeeper
You must deploy ZooKeeper as the first Pulsar component, as it is a dependency for the others.

$ oc apply -f zookeeper_sa.yaml
$ oc apply -f zookeeper_scc.yaml
$ oc adm policy add-scc-to-user zookeepersascc -z zookeepersa
$ oc apply -f zookeeper.yaml

### Initialize cluster metadata
Once ZooKeeper is running, you need to initialize the metadata for the Pulsar cluster in ZooKeeper. This includes system metadata for BookKeeper and Pulsar more broadly. There is a Kubernetes job in the cluster-metadata.yaml file that you only need to run once:

$ oc apply -f cluster-metadata.yaml

### Deploy the rest of the components

Once cluster metadata has been successfully initialized, you can then deploy the bookies, brokers and the Pulsar dashboard.

$ oc apply -f bookie.yaml

$ oc apply -f broker.yaml

$ oc apply -f pulsar-dashboard.yaml

