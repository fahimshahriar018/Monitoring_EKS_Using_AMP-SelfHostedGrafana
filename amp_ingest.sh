#!/bin/bash
export SERVICE_ACCOUNT_IAM_ROLE=EKS-AMP-ServiceAccount-Role
export SERVICE_ACCOUNT_IAM_ROLE_ARN=$(aws iam get-role --role-name $SERVICE_ACCOUNT_IAM_ROLE --query 'Role.Arn' --output text)

WORKSPACE_ID=$(aws amp list-workspaces --alias ${WORKSPACE_NAME} | jq .workspaces[0].workspaceId -r)

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
kubectl create ns prometheus

helm install prometheus-for-amp prometheus-community/prometheus -n prometheus -f ./amp_ingest_override_values.yaml \
--set serviceAccounts.server.annotations."eks\.amazonaws\.com/role-arn"="${SERVICE_ACCOUNT_IAM_ROLE_ARN}" \
--set server.remoteWrite[0].url="https://aps-workspaces.${AWS_REGION}.amazonaws.com/workspaces/${WORKSPACE_ID}/api/v1/remote_write" \
--set server.remoteWrite[0].sigv4.region=${AWS_REGION}

