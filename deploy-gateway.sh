#!/bin/bash
kubectl apply -f ./gateway-config.yaml
kubectl apply -f ./route-config.yaml
kubectl apply -f ./mapping.yaml
kubectl expose pod ServiceName-gateway-0 --port=80 --target-port=8080 --type=LoadBalancer
echo -n Waiting for external IP
until [ -n "$(kubectl get svc ServiceName-gateway-0 -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" ]; do
    sleep 2
    echo -n .
done
echo
echo Test Access to Managed Service
echo
echo curl http://$(kubectl get svc ServiceName-gateway-0 -o jsonpath='{.status.loadBalancer.ingress[0].ip}')/ServiceName
