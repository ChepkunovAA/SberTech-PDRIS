#!/bin/bash

SOURCE_DIR=$(pwd)
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

git clone $1 2>/dev/null
cd $(ls)

DIFF_CONTENT=$(git diff --name-status "origin/$2" "origin/$3" 2>/dev/null)
ADDED=$(echo "$DIFF_CONTENT" | grep -c '^A')
DELETED=$(echo "$DIFF_CONTENT" | grep -c '^D')
MODIFIED=$(echo "$DIFF_CONTENT" | grep -c '^M')
TOTAL=$(($ADDED+$DELETED+$MODIFIED))
{
    echo "Отчет о различиях между ветками"
    echo "================================"
    echo "Реопзиторий:    $1"
    echo "Ветка 1:        $2"
    echo "Ветка 2:        $3"
    echo "Дата генерации: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "================================"
    echo "СПИСОК ИЗМЕНЕННЫХ ФАЙЛОВ:"
    echo "$DIFF_CONTENT"
    echo "СТАТИСТИКА:"
    echo "Всего измененных файлов: $TOTAL"
    echo "Добавлено (A):    $ADDED"
    echo "Удалено (D):      $DELETED"
    echo "Изменено (M):     $MODIFIED"
} > "$SOURCE_DIR/diff_report_$2_vs_$3.txt"

cd $SOURCE_DIR
rm -rf "$TEMP_DIR"
