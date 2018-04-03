kubectl create ns nifi
kubectl create -f statefulset/nifi-bootstrap.yaml --namespace=nifi
kubectl create -f statefulset/service.yaml --namespace=nifi
kubectl create -f statefulset/statefulset.yaml --namespace=nifi
