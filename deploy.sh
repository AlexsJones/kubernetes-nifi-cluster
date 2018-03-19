kubectl create ns tmp || true
kubectl replace -f statefulset/nifi-bootstrap.yaml --namespace=tmp
kubectl replace -f statefulset/service.yaml --namespace=tmp
kubectl replace -f statefulset/statefulset.yaml --namespace=tmp
