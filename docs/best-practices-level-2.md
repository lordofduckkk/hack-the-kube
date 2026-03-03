# Level 2: Privileged Escape — Рекомендации по защите

## Уязвимая конфигурация

```yaml
# challenges/level-2-privileged-pod/deployment.yaml
securityContext:
  privileged: true
volumeMounts:
- name: host-root
  mountPath: /host
volumes:
- name: host-root
  hostPath:
    path: /
```

**Проблема:**
- `privileged: true` отключает изоляцию контейнера
- `hostPath: /` предоставляет доступ ко всей файловой системе хоста
- Комбинация позволяет выполнить escape из контейнера

---

## Рекомендуемая конфигурация

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: secure-app
  namespace: level-2
spec:
  template:
    spec:
      containers:
      - name: app
        image: alpine:3.19
        securityContext:
          privileged: false
          allowPrivilegeEscalation: false
          runAsNonRoot: true
          runAsUser: 1000
          readOnlyRootFilesystem: true
          capabilities:
            drop: ["ALL"]
        volumeMounts:
        - name: app-data
          mountPath: /data
      volumes:
      - name: app-data
        emptyDir: {}
```

---

## Сравнение подходов

| Аспект | Privileged + hostPath | Restricted Security Context |
|--------|----------------------|----------------------------|
| Доступ к /dev | Все устройства | Заблокировано |
| Доступ к ФС хоста | Полный | Отсутствует |
| Linux Capabilities | Все (SYS_ADMIN и др.) | Все отброшены |
| Запуск от root | Да | Нет |
| Запись в корневую ФС | Да | Только чтение |

---

## Источники

- Kubernetes Pod Security Standards (restricted profile)
- NSA/CISA Kubernetes Hardening Guide, §4.2: "Do not run privileged containers"
- CWE-250: Execution with Unnecessary Privileges

---

## Проверка

```bash
# Уязвимая конфигурация
kubectl exec -n level-2 deployment/escape-pod -- ls /host
# Вывод: (список файлов хоста)

# Безопасная конфигурация
kubectl exec -n level-2 deployment/secure-app -- ls /host
# Вывод: ls: cannot access '/host': No such file or directory
```

