kubectl create ns nifi
kubectl create -f deployment/service.yaml --namespace=nifi
kubectl create -f deployment/statefulset.yaml --namespace=nifi
