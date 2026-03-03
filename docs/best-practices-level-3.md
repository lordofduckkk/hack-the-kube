# Level 3: RBAC Escalation — Рекомендации по защите

## Уязвимая конфигурация

```yaml
# challenges/level-3-weak-rbac/rbac.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer-role
  namespace: kube-system
rules:
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["get", "list"]
```

```
kind: RoleBinding
metadata:
  name: developer-binding
  namespace: kube-system
subjects:
- kind: ServiceAccount
  name: developer-sa
  namespace: level-3
```

**Проблема:**
- ServiceAccount из application namespace имеет доступ к kube-system
- Возможность чтения секретов системных компонентов
- Cross-namespace binding нарушает изоляцию

---

## Рекомендуемая конфигурация

```yaml
# 1. ServiceAccount в своём namespace
apiVersion: v1
kind: ServiceAccount
metadata:
  name: app-sa
  namespace: level-3

---
# 2. Role в том же namespace
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: app-role
  namespace: level-3
rules:
- apiGroups: [""]
  resources: ["configmaps"]
  verbs: ["get", "list"]
  resourceNames: ["app-config"]

---
# 3. RoleBinding в том же namespace
kind: RoleBinding
metadata:
  name: app-binding
  namespace: level-3
subjects:
- kind: ServiceAccount
  name: app-sa
  namespace: level-3
roleRef:
  kind: Role
  name: app-role
  apiGroup: rbac.authorization.k8s.io
```

---

## Сравнение подходов

| Аспект | Cross-Namespace RBAC | Namespace-Scoped RBAC |
|--------|---------------------|----------------------|
| Доступ к kube-system | Да | Нет |
| Чтение secrets | Все секреты | Только configmaps |
| Scope ресурсов | Все | Конкретные (resourceNames) |
| Изоляция namespace | Нарушена | Соблюдена |
| Principle of Least Privilege | Нет | Да |

---

## Источники

- Kubernetes RBAC Documentation
- NSA/CISA Kubernetes Hardening Guide, §4.1: "Prefer namespace-scoped Role over ClusterRole"
- CWE-269: Improper Privilege Management
- CNCF Security Best Practices, §5.2: "Avoid cross-namespace RoleBindings"

---

## Проверка

```bash
# Уязвимая конфигурация
kubectl auth can-i get secrets -n kube-system \
  --as=system:serviceaccount:level-3:developer-sa
# Вывод: yes

# Безопасная конфигурация
kubectl auth can-i get secrets -n kube-system \
  --as=system:serviceaccount:level-3:app-sa
# Вывод: no
```


