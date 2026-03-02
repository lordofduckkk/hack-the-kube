#!/bin/bash
echo "🧪 Тест кластера..."
kubectl cluster-info && echo "✅ OK" || echo "❌ FAIL"
kubectl get nodes && echo "✅ OK" || echo "❌ FAIL"
