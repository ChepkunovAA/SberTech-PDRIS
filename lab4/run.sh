#!/bin/bash

echo "Подключение к приложению..."
minikube kubectl -- attach -n diary-app deployment/diary-app -c diary-app -i -t