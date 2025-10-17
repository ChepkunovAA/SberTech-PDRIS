#!/bin/bash

IMAGE_NAME="docker-diary-app"
REGISTRY=$1

echo "Сборка Docker образа..."
docker build -t $IMAGE_NAME .
echo "Сборка Docker образа завершена"

echo "Отправка образа в registry..."
docker tag $IMAGE_NAME $REGISTRY/$IMAGE_NAME
docker push $REGISTRY/$IMAGE_NAME
echo "Отправка завершена"