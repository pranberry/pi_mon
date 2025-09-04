#!/usr/bin/bash

LOGFILE="/opt/pi_monitor/undervolt.html"
STATUS=$(vcgencmd get_throttled | awk -F= '{print $2}')
TEMP=$(vcgencmd measure_temp | awk -F= '{print $2}')
if [[ "$STATUS" != "0x0" ]]; then
    {
    echo "<html><head><meta http-equiv='refresh' content='30'>"
    echo "<title>Undervoltage Monitor</title></head><body>"
    echo "<h1>Undervoltage Monitor</h1>"
    echo "<p>Last updated: $(date)</p>"

    echo "<h2>vcgencmd (throttling status)</h2>"
    echo "<pre>$(STATUS)</pre>"

    echo "<h2>vcgencmd (throttling status)</h2>"
    echo "<pre>$(TEMP)</pre>"

    echo "<h2>iotop (top I/O processes)</h2>"
    echo "<pre>$(iotop -b -n 1 -o 2>&1)</pre>"

    echo "<h2>uptime</h2>"
    echo "<pre>$(uptime)</pre>"

    echo "<h2>free -h (memory)</h2>"
    echo "<pre>$(free -h)</pre>"

    echo "</body></html>"
    } >> "$LOGFILE"
else
    {
        echo "<html><head><meta http-equiv='refresh' content='30'>"
        echo "<title>Undervoltage Monitor</title></head><body>"
        echo "<h3>Nothing to report</h3>"
        echo "</body></html>"
    } >> "$LOGFILE"
    }
fi
