#!/usr/bin/bash

LOGFILE="/opt/pi_monitor/undervolt.log"
STATUS=$(vcgencmd get_throttled | awk -F= '{print $2}')
TEMP=$(vcgencmd measure_temp | awk -F= '{print $2}')
if [[ "$STATUS" != "0x0"]]; then
    {
        echo "==== $(date) ===="
        echo "get_throttled status: $STATUS"
        echo "temp: $TEMP"
        echo "Uptime: "
        uptime
        echo "Memory:"
        free -h
        echo "Disk I/O:"
        iotop -b -n 1 -o 2>/dev/null
        echo
    } >> "$LOGFILE"
fi