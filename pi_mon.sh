#!/usr/bin/bash

LOGFILE="/dev/shm/undervolt.html"
STATUS=$(vcgencmd get_throttled | awk -F= '{print $2}')
TEMP=$(vcgencmd measure_temp | awk -F= '{print $2}')
if [[ "$STATUS" != "0x0" ]]; then
    {
    echo "<html><head><meta http-equiv='refresh' content='30'>"
    echo "<title>Undervoltage Monitor</title></head><body>"
    echo "<table>
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
            <tr>
              <td>iotop (top I/O processes)</td>
              <td>$(iotop -b -n 1 -o 2>&1)</td>
            </tr>
            <tr>
              <td>uptime</td>
              <td>$(uptime)</td>
            </tr>
            <tr>
              <td>free -h (memory)</td>
              <td>$(free -h)</td>
            </tr>
          </tbody>
        </table>"
    echo "<h3>===========================</h3>"
    echo "</body></html>"
    } >> "$LOGFILE"
else
    {
        echo "<html><head><meta http-equiv='refresh' content='30'>"
        echo "<title>Undervoltage Monitor</title></head><body>"
        echo "<table>
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

