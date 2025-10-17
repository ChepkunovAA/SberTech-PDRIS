#!/bin/bash

if ! docker ps -a | grep -q "diary_app"; then
    echo "Сборка приложения Дневник..."
    docker-compose build > /dev/null 2>&1
fi

echo "Запуск приложения Дневник..."
docker-compose up -d > /dev/null 2>&1

docker attach diary_app
