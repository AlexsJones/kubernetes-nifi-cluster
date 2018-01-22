# kubernetes-nifi-cluster

Three node nifi cluster running in kubernetes-nifi-cluster

Based on the image: https://hub.docker.com/r/xemuliam/nifi/

However, there is customisation in two areas
- This is run as a kubernetes statefulset with persistent volume claims
- Host mapping is done on pod start to correctly add IP addresses (zookeeper returns the hostname not the full .service.cluster.local)

## Requirements

- Requires [zookeeper](https://github.com/AlexsJones/kubernetes-zookeeper-cluster) running in the namespace zookeeper (three nodes referenced in the sts)

- [Vortex](https://github.com/AlexsJones/vortex) For interpolating build commands


## Usage

- `./build_environment.sh preview`
- `kubectl create ns nifi`
- `kubectl create -f ./deployment/statefulset --namespace=nifi`


### Add nodes

Currently the easiest way would be to rebuild the docker image
*This also means scaling is an issue currently*

### Production readiness

Apart from the scaling issue I'd recommend upping the persistent volume claim size.
