# kubernetes-nifi-cluster

Three node nifi cluster running in kubernetes-nifi-cluster

However, there is customisation in two areas
- This is run as a kubernetes statefulset with persistent volume claims
- Host mapping is done on pod start to correctly add IP addresses (zookeeper returns the hostname not the full .service.cluster.local)

## _Secure SSL Cluster guide coming soon_


### Requirements


- Requires [zookeeper](https://github.com/AlexsJones/kubernetes-zookeeper-cluster) running in the namespace zookeeper (three nodes referenced in the sts)


### Usage
```
# https://github.com/AlexsJones/kubernetes-zookeeper-cluster
# from this repo run
kubectl create ns zookeeper
kubectl create -f poddisruptionbudget.yaml --namespace=zookeeper
kubectl create -f micro/statefulset.yaml --namespace=zookeeper
kubectl create -f service.yaml --namespace=zookeeper

# from the nifi repo run the following
kubectl create ns nifi
kubectl create -f statefulset/ --namespace=nifi
```

![nifi](https://i.imgur.com/pK3pulW.jpg)
---

## Issues

The primary issue that causes all of the headaches with scaling and getting this all working is to do with the way Kubernetes statefulsets are unable to resolve each other via dns. At time of writing this its not possible for one statefulset pod to see another; this essentially means unless you're doing FQDN via external DNS and back-in, you'll have to use the solution I've come up with (happy for other suggestions - perhaps some proxy service or side car).

### Add nodes

Currently the easiest way would be to rebuild the docker image due to the issue with the
*This also means scaling is an issue currently*

`https://github.com/AlexsJones/kubernetes-nifi-cluster/blob/master/files/run.sh#L9`

Here you'll have to add the new node.

### Production readiness

Apart from the scaling issue I'd recommend upping the persistent volume claim size.
Ideally I'd find a solution for the dynamic node situation, but I haven't found any other Nifi K8s manifests let alone covering this issue just yet.
