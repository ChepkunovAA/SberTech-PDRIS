import os
import time
from datetime import datetime

import psycopg2


def wait_for_db():
    print("Ожидание подключения к БД...")
    while True:
        try:
            conn = psycopg2.connect(
                host=os.getenv('DB_HOST', 'db'),
                database=os.getenv('DB_NAME', 'postgres'),
                user=os.getenv('DB_USER', 'postgres'),
                password=os.getenv('DB_PASSWORD', 'password'),
                port=os.getenv('DB_PORT', '5432')
            )
            conn.close()
            print("Подключение к БД установлено")
            return True
        except Exception:
            time.sleep(2)


def init_db():
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST', 'db'),
        database=os.getenv('DB_NAME', 'postgres'),
        user=os.getenv('DB_USER', 'postgres'),
        password=os.getenv('DB_PASSWORD', 'password'),
        port=os.getenv('DB_PORT', '5432')
    )
    c = conn.cursor()
    c.execute('''CREATE TABLE IF NOT EXISTS diary
                 (id SERIAL PRIMARY KEY,
                  entry TEXT,
                  created_at TIMESTAMP)''')
    conn.commit()
    conn.close()


def save_entry(entry):
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST', 'db'),
        database=os.getenv('DB_NAME', 'postgres'),
        user=os.getenv('DB_USER', 'postgres'),
        password=os.getenv('DB_PASSWORD', 'password'),
        port=os.getenv('DB_PORT', '5432')
    )
    c = conn.cursor()
    c.execute("INSERT INTO diary (entry, created_at) VALUES (%s, %s)",
              (entry, datetime.now()))
    conn.commit()
    conn.close()
    print(f"Запись \"{entry}\" сохранена")


def show_entries(limit=None):
    conn = psycopg2.connect(
        host=os.getenv('DB_HOST', 'db'),
        database=os.getenv('DB_NAME', 'postgres'),
        user=os.getenv('DB_USER', 'postgres'),
        password=os.getenv('DB_PASSWORD', 'password'),
        port=os.getenv('DB_PORT', '5432')
    )
    c = conn.cursor()
    if limit is None:
        c.execute("SELECT * FROM diary ORDER BY created_at DESC LIMIT 5")
    else:
        c.execute("SELECT * FROM diary ORDER BY created_at DESC LIMIT %s", (limit,))
    entries = c.fetchall()
    conn.close()

    for entry in entries:
        print(f"{entry[2]}: {entry[1]}")


help_message = "Приложение для ведения дневника. Команды:\n" \
               " - write [новая запись] - сделать запись\n" \
               " - show [количество] - показать последние записи (по умолчанию все)\n" \
               " - exit - выйти\n" \
               " - help - вывести это сообщение"


if __name__ == "__main__":
    wait_for_db()
    init_db()

    print(help_message)

    while True:
        try:

            user_input = input().strip().split(maxsplit=1)
            if len(user_input) == 0:
                continue

            match user_input[0].lower():
                case 'exit':
                    print("Выход...")
                    exit(0)
                case 'show':
                    limit = None
                    if len(user_input) > 1:
                        try:
                            limit = int(user_input[1])
                        except ValueError:
                            raise RuntimeError("Количество должно быть числом")
                    show_entries(limit)
                case 'write':
                    if len(user_input) == 1:
                        raise RuntimeError("Пустая запись")
                    save_entry(user_input[1].strip())
                case 'help':
                    print(help_message)
                case _:
                    print("Неизвестная команда! Введите help для справки\n")
        except Exception as e:
            print(f"Ошибка: {e}")
