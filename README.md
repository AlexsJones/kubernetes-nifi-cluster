# kubernetes-nifi-cluster

A nifi cluster running in kubernetes-nifi-cluster

## Major update March2019

_Secure SSL Cluster guide coming soon_

### Prerequisites

- Requires [vortex](https://github.com/AlexsJones/vortex)
  - Requires golang installed and on the path
  - Can be installed with `go get github.com/AlexsJones/vortex`

- Requires [zookeeper](https://github.com/AlexsJones/kubernetes-zookeeper-cluster)

from the zookeeper repo repo run:
```
kubectl create ns zk
kubectl create -f poddisruptionbudget.yaml --namespace=zk
kubectl create -f micro/statefulset.yaml --namespace=zk
kubectl create -f service.yaml --namespace=zk
```

Now zookeeper is setup with three nodes on the zk namespace you are ready!

### Usage

```
./build_environment.sh default
kubectl create -f deployment/
```

---

## UI

http://<LB_IP>:8080/nifi/


## Configuration

The `environments/` folder can have new files added and used with `build_environment.sh <envname>` and those values interpolated
For more informatino on this please see [here](https://github.com/AlexsJones/vortex/blob/master/README.md)

### Production readiness

I will eventually write a guide for SSL but its a real pain in the ass (keystore/truststore dynamic generation and sharing.)

Apart from the scaling issue I'd recommend upping the persistent volume claim size.
Ideally I'd find a solution for the dynamic node situation, but I haven't found any other Nifi K8s manifests let alone covering this issue just yet.
