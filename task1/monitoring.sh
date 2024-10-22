#!/bin/bash

PIDFILE="/tmp/monitoring.pid"

monitor() {
    local START_TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
    local DATE=$(date '+%Y%m%d')
    local OUTPUT_FILE="monitoring_${DATE}_${START_TIMESTAMP}.csv"
    echo "Timestamp,FS,Used%,Available,FreeInodes" > $OUTPUT_FILE

    local SLEEP_FOR=60
    while true; do
        local NEW_DATE=$(date '+%Y%m%d')
        if [[ "$NEW_DATE" != "$DATE" ]]; then
            DATE="$NEW_DATE"
            OUTPUT_FILE="monitor_${DATE}_${START_TIMESTAMP}.csv"
            echo "Timestamp,FS,UsedS%,Available,FreeInodes" > $OUTPUT_FILE
        fi

        df -hP | awk 'NR>1 {print $1,$5,$4,$6}' | while read filesystem used_percent available mounted_on; do
            free_inodes=$(df -hiP | awk -v fs="$filesystem" '$1==fs {print $4}')
            echo "$(date '+%Y-%m-%d %H:%M:%S'),$filesystem,$used_percent,$available,$free_inodes" >> $OUTPUT_FILE
        done

        sleep $SLEEP_FOR
    done
}

start() {
    if [[ -f "$PIDFILE" ]]; then
        echo "Monitoring is already launched with PID $(cat "$PIDFILE")"
        exit 1
    fi
    monitor & echo $! > "$PIDFILE"
    echo "Launching monitoring with PID $(cat "$PIDFILE")..."
}

stop() {
    if [[ -f "$PIDFILE" ]]; then
        echo "Stopping monitoring with PID $(cat "$PIDFILE")..."
        kill $(cat "$PIDFILE") && rm -f "$PIDFILE"
        
    else
        echo "Monitoring is not launched"
        exit 1
    fi
}


status() {
    if [[ -f "$PIDFILE" ]]; then
        echo "Monitoring is already launched with PID $(cat "$PIDFILE")"
    else
        echo "Monitoring is not launched"
    fi
}

if [[ "$1" == "START" ]]; then
    start
elif [[ "$1" == "STOP" ]]; then
    stop
elif [[ "$1" == "STATUS" ]]; then
    status
else
    echo "Usage: $0 START|STOP|STATUS"
    exit 1
fi
