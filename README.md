# github-action
# Flask App with Kubernetes Deployment

This is a simple Python Flask app designed to be containerized and deployed to Kubernetes.

## Features

- Basic Flask web app
- Styled with CSS
- Deployed via Kubernetes YAML manifests

## Usage

1. Build and run the Docker container
2. Apply Kubernetes files:
   ```bash
   kubectl apply -f k8s/namespace.yaml
   kubectl apply -f k8s/
