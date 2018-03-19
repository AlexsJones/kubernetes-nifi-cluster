kubectl create ns nifi || true
kubectl replace -f statefulset/nifi-bootstrap.yaml --namespace=nifi
kubectl replace -f statefulset/service.yaml --namespace=nifi
kubectl replace -f statefulset/statefulset.yaml --namespace=nifi
