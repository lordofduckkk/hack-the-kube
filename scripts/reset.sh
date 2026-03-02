#!/bin/bash
echo "🗑️  Сброс..."
kind delete clusters --all
rm -rf /tmp/hack-the-kube
echo "✅ Готово"
