#!/bin/bash
helm repo add grafana https://grafana.github.io/helm-charts
kubectl create ns grafana

helm install grafana-for-amp grafana/grafana -n grafana --set persistence.storageClassName="gp2" --set persistence.enabled=true  --set adminPassword='EKS!sAWSome' --set service.type=LoadBalancer

helm upgrade --install grafana-for-amp grafana/grafana -n grafana -f ./amp_query_override_values.yaml --set persistence.storageClassName="gp2" --set persistence.enabled=true  --set adminPassword='EKS!sAWSome' --set service.type=LoadBalancer