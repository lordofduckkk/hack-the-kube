# Level 1: Secrets Leak — Рекомендации по защите

## Уязвимая конфигурация

```yaml
# challenges/level-1-secrets-leak/deployment.yaml
env:
- name: DB_PASSWORD
  value: "HTK{f0und_s3cr3t_1n_env_vars}"
```

**Проблема:**
- Пароль отображается в выводе `kubectl describe pod`
- Данные хранятся в открытом виде в etcd
- Любой пользователь с доступом к pods может прочитать секрет

---

## Рекомендуемая конфигурация

```yaml
# 1. Создание Secret
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
  namespace: level-1
type: Opaque
stringData:
  db-password: "super-secret-password"

---
# 2. Подключение Secret в Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: secure-app
  namespace: level-1
spec:
  template:
    spec:
      containers:
      - name: app
        image: nginx:alpine
        envFrom:
        - secretRef:
            name: app-secrets
```

**Альтернатива — монтирование как файл:**

```yaml
volumeMounts:
- name: secrets
  mountPath: /etc/secrets
  readOnly: true
volumes:
- name: secrets
  secret:
    secretName: app-secrets
    defaultMode: 0400
```

---

## Сравнение подходов

| Аспект | Environment Variable | Kubernetes Secret |
|--------|---------------------|-------------------|
| Видимость в kubectl describe | Видно | Скрыто |
| Шифрование в etcd | Нет | Да (при настройке encryption-provider) |
| Контроль доступа | Через RBAC на pods | Через RBAC на secrets |
| Ротация | Требует пересоздания pod | Можно обновить без redeploy |

---

## Источники

- NIST SP 800-190, §4.3.2: "Secrets should not be stored in container images or environment variables"
- CWE-312: Cleartext Storage of Sensitive Information

