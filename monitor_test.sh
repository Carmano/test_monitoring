#!/bin/bash

PROCESS_TARGET="test"
URL="https://test.com/monitoring/test/api"
LOG_FILE="/var/log/monitoring.log"
STATE_FILE="/tmp/monitor_test.state"


log () {
   echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

pid=$(pgrep -x "$PROCESS_TARGET")
if [[ -z "$pid" ]]; then
    echo $pid
    exit 0
fi


if [[ ! -f $STATE_FILE ]]; then
   echo "$pid" > "$STATE_FILE"
fi

prev_pid=$(cat "$STATE_FILE" 2>/dev/null)
if [[ "$pid" != "$prev_pid" ]]; then
    log "$PROCESS_TARGET process restarted. New PID: $pid" >> "$LOG_FILE"
    echo "$pid" > $STATE_FILE
fi

RESPONSE=$(curl --write-out "%{http_code}" --silent --output /dev/null --connect-timeout 10 "$URL")

if [[ $RESPONSE -ne 200 ]]; then 
    log "$URL недоступен. Код ответа: $RESPONSE"
fi 

