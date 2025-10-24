echo "Сборка и запуск контейнеров..."
docker-compose up -d --build > /dev/null 2>&1

echo "Запуск ansible..."
docker exec ansible-control ansible-playbook example.yml -i example.hosts