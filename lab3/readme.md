# Лабораторная работа 2

Консольное приложение "Дневник", развёрнутое с использованием ansible

## 1: Сборка инфраструктуры

```bash
chmod +x build.sh
./build.sh
```

## 2: Проверка nginx

```bash
curl http://localhost:8080
```

## 3: Запуск приложения

```bash
ssh admin@localhost -p 5555 # пароль - securepassword
python3 /app/app.py
```

## 4: Для ручной сборки иинфраструктуры

```bash
docker-compose up -d --build > /dev/null 2>&1
docker exec ansible-control ansible-playbook example.yml -i example.hosts
```

Скрины, подтверждающие работоспособность находятся в поддиректории `doc`