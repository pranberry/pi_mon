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

    echo "<p>vcgencmd (throttling status)</p>"
    echo "<pre>$STATUS</pre>"

    echo "<p>vcgencmd (throttling status)</p>"
    echo "<pre>$TEMP</pre>"

    echo "<p>iotop (top I/O processes)</p>"
    echo "<pre>$(iotop -b -n 1 -o 2>&1)</pre>"

    echo "<p>uptime</p>"
    echo "<pre>$(uptime)</pre>"

    echo "<p>free -h (memory)</p>"
    echo "<pre>$(free -h)</pre>"

    echo "<h3>===========================</h3>"
    echo "</body></html>"
    } >> "$LOGFILE"
else
    {
        echo "<html><head><meta http-equiv='refresh' content='30'>"
        echo "<title>Undervoltage Monitor</title></head><body>"
        echo "<table>
          <thead>
            <tr>
              <th>Undervoltage Monitor</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Last Updated</td>
              <td>$(date)</td>
            </tr>
            <tr>
              <td>vcgencmd (throttling status)</td>
              <td>$STATUS</td>
            </tr>
            <tr>
              <td>Temp</td>
              <td>$TEMP</td>
            </tr>
          </tbody>
        </table>"
        echo "<h3>===========================</h3>"
        echo "</body></html>"
    } >> "$LOGFILE"
fi

