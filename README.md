# 🛡️ HackTheKube

Учебный стенд по безопасности Kubernetes для отработки навыков атаки и защиты.

## 🚀 Быстрый старт

### Требования
- Docker 20.10+
- kubectl 1.25+
- kind 0.20+
- 8 GB RAM, 4 CPU, 20 GB disk

### Установка
```bash
# 1. Клонировать репозиторий
cd ~/hack-the-kube

# 2. Поднять кластер
make up

# 3. Развернуть сценарии
kubectl apply -f challenges/level-1-secrets-leak/
kubectl apply -f challenges/level-2-privileged-pod/
kubectl apply -f challenges/level-3-weak-rbac/
```

## 🎯 Уровни

| Уровень | Название | Уязвимость | Время |
|---------|----------|------------|-------|
| 🟢 Level 1 | Secrets Leak | CWE-312 | 15 мин |
| 🟡 Level 2 | Privileged Escape | CWE-250 | 30 мин |
| 🔴 Level 3 | RBAC Escalation | CWE-269 | 45 мин |

## 🧪 Валидация флагов

```bash
# Уровень 1
bash challenges/level-1-secrets-leak/validate.sh "HTK{...}"

# Уровень 2
bash challenges/level-2-privileged-pod/validate.sh "HTK{...}"

# Уровень 3
bash challenges/level-3-weak-rbac/validate.sh "HTK{...}"
```

## 🗑️ Очистка

```bash
# Удалить кластер
make down

# Удалить всё
kind delete clusters --all
```

## 📁 Структура

```
hack-the-kube/
├── cluster/              # Kind конфиги
├── challenges/           # Сценарии атак
│   ├── level-1-secrets-leak/
│   ├── level-2-privileged-pod/
│   └── level-3-weak-rbac/
├── scripts/              # Утилиты
├── docs/                 # Документация
├── Makefile              # Автоматизация
└── README.md
```

## 📄 Лицензия

MIT
