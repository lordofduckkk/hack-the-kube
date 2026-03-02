#!/bin/bash
echo "🧪 Тест уровней..."
kubectl get pods -n level-1 | grep Running && echo "✅ Level 1" || echo "❌ Level 1"
kubectl get pods -n level-2 | grep Running && echo "✅ Level 2" || echo "❌ Level 2"
kubectl get pods -n level-3 | grep Running && echo "✅ Level 3" || echo "❌ Level 3"
