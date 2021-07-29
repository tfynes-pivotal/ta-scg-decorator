#!/bin/bash
echo Register Spring Cloud Gateway Operator with API Portal
kubectl -n api-portal set env deployment.apps/api-portal-server API_PORTAL_SOURCE_URLS="https://petstore.swagger.io/v2/swagger.json, https://petstore3.swagger.io/api/v3/openapi.json,$(kubectl -n spring-cloud-gateway get svc scg-operator -o jsonpath='{.status.loadBalancer.ingress[0].ip}')/openapi"

kubectl -n api-portal rollout restart deployment api-portal-server

echo Visit API Portal Service here: http://$(kubectl -n api-portal get svc api-portal-server -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

