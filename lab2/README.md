# Лабораторная работа 2

Консольное приложение "Дневник"

## 1: Сборка образа и отправка в Docker Registry

```bash
chmod +x build_and_push.sh
./build_and_push.sh [your-registry-domain]
```

## 2: Сборка и запуск приложения из исходников

```bash
chmod +x run.sh
./run.sh
```

## 3: Для ручной сборки и запуска

```bash
docker-compose build
docker-compose up -d
docker attach diary_app
```

Скрины, подтверждающие работоспособность находятся в поддиректории `doc`