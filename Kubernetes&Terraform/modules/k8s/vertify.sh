#!/bin/bash

##I started Minikube (assumed GCP as the driver, adjusted accordingly)
minikube start --driver=gcp

#Then I set the KUBECONFIG environment variable to point to the Kubernetes configuration
export KUBECONFIG=~/.kube/config

#Then I ran Terraform to deploy resources
terraform init
terraform apply -auto-approve

#I retrieved the namespace name from Terraform output,
NAMESPACE_NAME=$(terraform output -raw exam_namespace)
if [ -z "$NAMESPACE_NAME" ]; then
  echo "Error: Namespace name was not found in Terraform output."
  exit 1
fi

# Verified that the namespace existed
NAMESPACE_EXIST=$(kubectl get namespaces | grep $NAMESPACE_NAME | wc -l)
if [ $NAMESPACE_EXIST -eq 1 ]; then
  echo "Namespace '$NAMESPACE_NAME' existed."
else
  echo "Namespace '$NAMESPACE_NAME' did not exist. Something went wrong."
  exit 1
fi

# Waited for the container to be in a running state
POD_NAME=$(kubectl get pods -n $NAMESPACE_NAME -l app=nginx -o jsonpath="{.items[0].metadata.name}")
kubectl wait --for=condition=ready pod/$POD_NAME -n $NAMESPACE_NAME --timeout=30s

# Verified that the container was running
CONTAINER_STATUS=$(kubectl get pod $POD_NAME -n $NAMESPACE_NAME -o jsonpath="{.status.containerStatuses[0].state.running}")
if [ -n "$CONTAINER_STATUS" ]; then
  echo "Container was running."
else
  echo "Container was not running. Something went wrong."
  exit 1
fi

# Cleaned up Terraform resources
terraform destroy -auto-approve

# Stopped Minikube
minikube stop

echo "Verification was successful. Cleanup was completed."
