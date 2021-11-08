#!bin/bash
export AWS_REGION=us-west-2
export WORKSPACE_NAME=test-amp-workspace
aws amp create-workspace --alias $WORKSPACE_NAME --region $AWS_REGION