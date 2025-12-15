# Лабораторная работа №5

Jenkinsfile.build загружает код из ветки lab5-app, запускает тесты, статический анализ, генерирует Allure-отчёт и загружает в Nexus
Jenkinsfile.deploy скачивает jar из Nexus, скачивает и запускает ansible playbook находящийся в этой ветке

Логи исполнения пайплайнов и скриншоты успешной отработки находятся в директории doc

Для развёртывания с помощью docker-compose.yml собрать и запустить контейнеры с Jenkins, SonarQube, Nexus; войти в веб-интерфейс Jenkins, установить все необходимые дополнительные плагины (Allure, Ansible, Nexus Artifact UploaderSonarQube Scanner), настроить необходимые tools (jdk, maven, Ansible, SonarQube, Allure), создать credentials для sonarqube и nexus, после чего запустить развёртывание в новом item с загруженным нужным pipeline'ом