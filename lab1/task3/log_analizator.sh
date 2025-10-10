#!/bin/bash

LOG_FILE=$1
KEYWORD=$2
COUNT_FILE="error_count_$1_$2.txt"
ERRORS_FILE="errors_$1_$2.txt"

ERROR_COUNT=$(grep -c -w "$2" "$1")
grep -w "$2" "$1" > "$ERRORS_FILE"

{
    echo "Отчет анализа лог-файла"
    echo "========================"
    echo "Лог-файл:    $1"
    echo "Ключевое слово: $2"
    echo "Дата генерации: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================"
    echo "Количество найденных ошибок: $ERROR_COUNT"
    echo "Файл с ошибками: $ERRORS_FILE"
} > "$COUNT_FILE"

echo "Анализ завершен:"
echo "Найдено ошибок: $ERROR_COUNT"
echo "Статистика сохранена в: $COUNT_FILE"
echo "Список ошибок сохранен в: $ERRORS_FILE"