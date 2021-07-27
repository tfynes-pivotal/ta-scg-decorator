#!/bin/bash
kubectl apply -f ./gateway-config.yaml
kubectl apply -f ./route-config.yaml
kubectl apply -f ./mapping.yaml
kubect expose pod ServiceName-gateway-0 --port=80 --target-port=8080 --type=LoadBalancer
