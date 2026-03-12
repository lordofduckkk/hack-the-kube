.PHONY: up down reset test help

CLUSTER_NAME := hack-the-kube
KIND_CONFIG := cluster/kind-config.yaml

help:
	@echo "HackTheKube — команды:"
	@echo "  make up    - Создать кластер"
	@echo "  make down  - Удалить кластер"
	@echo "  make reset - Пересоздать"
	@echo "  make test  - Проверка"

up:
	@echo "Создание кластера..."
	@kind create cluster --config $(KIND_CONFIG) --name $(CLUSTER_NAME)
	@echo "Готово!"

down:
	@echo "Удаление"
	@kind delete cluster --name $(CLUSTER_NAME)
	@echo "Удалено"

reset: down up

test:
	@kubectl get nodes
	@echo "Тест пройден"
