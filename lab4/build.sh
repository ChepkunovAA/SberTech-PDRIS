#!/bin/bash

minikube start
eval $(minikube docker-env)

echo "Сборка Docker образа..."
docker build -t diary-app:latest .
echo "Сборка Docker образа завершена"

echo "Запуск кластера..."
minikube kubectl -- apply -f k8s/namespace.yaml

minikube kubectl -- apply -f k8s/pv.yaml
minikube kubectl -- apply -f k8s/postgres.yaml
minikube kubectl -- apply -f k8s/postgres-service.yaml

minikube kubectl -- apply -f k8s/app.yaml
minikube kubectl -- apply -f k8s/app-service.yaml
echo "Запуск кластера завершен"