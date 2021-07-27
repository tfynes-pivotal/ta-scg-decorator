#!/bin/bash
kubectl delete -f ./gateway-config.yaml
kubectl delete -f ./route-config.yaml
kubectl delete -f ./mapping.yaml
kubectl delete service ServiceName-gateway-0 
