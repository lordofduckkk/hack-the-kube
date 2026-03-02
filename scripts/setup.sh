#!/bin/bash
echo "🚀 Развертывание сценариев..."

# Level 1
kubectl apply -f challenges/level-1-secrets-leak/namespace.yaml
kubectl apply -f challenges/level-1-secrets-leak/deployment.yaml

# Level 2
kubectl apply -f challenges/level-2-privileged-pod/namespace.yaml
kubectl apply -f challenges/level-2-privileged-pod/deployment.yaml

# Level 3
kubectl apply -f challenges/level-3-weak-rbac/namespace.yaml
kubectl apply -f challenges/level-3-weak-rbac/rbac.yaml
kubectl apply -f challenges/level-3-weak-rbac/flag-secret.yaml
kubectl apply -f challenges/level-3-weak-rbac/deployment.yaml

echo "✅ Готово"
