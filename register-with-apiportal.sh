#!/bin/bash
echo Register Spring Cloud Gateway Operator with API Portal
kubectl -n api-portal set env deployment.apps/api-portal-server API_PORTAL_SOURCE_URLS="https://petstore.swagger.io/v2/swagger.json, https://petstore3.swagger.io/api/v3/openapi.json,http://$(kubectl -n spring-cloud-gateway get svc scg-operator -o jsonpath='{.status.loadBalancer.ingress[0].ip}')/openapi"

kubectl -n api-portal rollout restart deployment api-portal-server

# update api-portal server to expose UI directly using a load-balancer
kubectl -n api-portal patch svc api-portal-server --type merge -p '{"spec":{"ports": [{"port": 80, "targetPort":8080 }]}}'
kubectl -n api-portal patch svc api-portal-server -p '{"spec":{"type":"LoadBalancer"}}'

echo Visit API Portal Service here: http://$(kubectl -n api-portal get svc api-portal-server -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

