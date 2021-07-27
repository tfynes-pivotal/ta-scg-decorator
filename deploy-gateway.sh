#!/bin/bash
kubectl apply -f ./gateway-config.yaml
kubectl apply -f ./route-config.yaml
kubectl apply -f ./mapping.yaml
