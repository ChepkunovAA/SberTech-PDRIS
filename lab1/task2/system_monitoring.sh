#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
PID_FILE="/tmp/system_monitor.pid"
LOG_DIR="$SCRIPT_DIR/system_monitor_logs"

get_metrics() {
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    memory_info=$(free | grep Mem)
    total_memory=$(echo $memory_info | awk '{print $2}')
    used_memory=$(echo $memory_info | awk '{print $3}')
    free_memory=$(echo $memory_info | awk '{print $4}')
    memory_used_percent=$(( used_memory * 100 / total_memory ))
    
    cpu_used=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    
    disk_used=$(df / | tail -n1 | awk '{print $5}' | cut -d'%' -f1)

    load_average=$(cat /proc/loadavg | awk '{print $1}')
    
    echo "${timestamp};${total_memory};${free_memory};${memory_used_percent};${cpu_used};${disk_used};${load_average}"
}

monitor_loop() {
    while true; do
        metrics=$(get_metrics)
        today=$(date '+%Y-%m-%d')
        csv_file="${LOG_DIR}/system_report_${today}.csv"
    
        if [ ! -f "$csv_file" ]; then
            echo "timestamp;all_memory;free_memory;%memory_used;%cpu_used;%disk_used;load_average_1m" > "$csv_file"
        fi
    
        echo "$metrics" >> "$csv_file"

        sleep 600
    done
}

is_running() {
    if [ -f "$PID_FILE" ]; then
        pid=$(cat "$PID_FILE")
        if kill -0 "$pid" 2>/dev/null; then
            return 0
        else
            rm -f "$PID_FILE"
        fi
    fi
    return 1
}

print_status() {
    if is_running; then
       pid=$(cat "$PID_FILE")
       echo "Скрипт мониторинга запущен (PID: $pid)"
    else
       echo "Скрипт мониторинга не запущен"
    fi
}

start_monitor() {
    if is_running; then
        pid=$(cat "$PID_FILE")
        echo "Скрипт мониторинга запущен (PID: $pid)"
        return
    fi
    
    mkdir -p "$LOG_DIR"
    monitor_loop &
    pid=$!
    echo "$pid" > "$PID_FILE"
    echo "Скрипт запущен (PID: $pid)"
}

stop_monitor() {
    if is_running; then
        pid=$(cat "$PID_FILE")
        kill "$pid"
        rm -f "$PID_FILE"
    fi
}

case "${1^^}" in
    START)
        start_monitor
        ;;
    STOP)
        stop_monitor
        ;;
    STATUS)
        print_status
        ;;
esac