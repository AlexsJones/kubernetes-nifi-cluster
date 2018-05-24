#!/bin/bash

if [ -z "$(ls -A kubernetes-zookeeper-cluster)" ]; then
   echo "Requires kubernetes-zookeeper-cluster to be pulled with git submodule update --recursive --init"
   exit 1
fi

pushd kubernetes-zookeeper-cluster
# Gives a toy ZK setup (production for a larger cluster)
./build_environment.sh small
echo "Creating zookeeper namespace & sts/zk..."
kubectl create ns zookeeper
kubectl create -f deployment/ --namespace=zookeeper
echo "Waiting 10 seconds then testing the zk-0 pod"
sleep 10
kubectl exec zk-0 cat /opt/zookeeper/conf/zoo.cfg --namespace=zookeeper
popd
echo "Creating nifi namespace & sts/nifi..."
kubectl create ns nifi
kubectl create -f statefulset/nifi-bootstrap.yaml --namespace=nifi
kubectl create -f statefulset/service.yaml --namespace=nifi
kubectl create -f statefulset/statefulset.yaml --namespace=nifi
