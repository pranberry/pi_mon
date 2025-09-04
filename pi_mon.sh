#!/usr/bin/bash

LOGFILE="/dev/shm/undervolt.html"
STATUS=$(vcgencmd get_throttled | awk -F= '{print $2}')
TEMP=$(vcgencmd measure_temp | awk -F= '{print $2}')
if [[ "$STATUS" != "0x0" ]]; then
cat <<EOF >> "$LOGFILE"
<html>
<head><meta http-equiv='refresh' content='30'>
<title>Undervoltage Monitor</title></head>
<body>
<table>
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
      <td><pre>$(iotop -b -n 1 -o 2>&1)</pre></td>
    </tr>
    <tr>
      <td>uptime</td>
      <td>$(uptime)</td>
    </tr>
    <tr>
      <td>free -h (memory)</td>
      <td><pre>$(free -h)</pre></td>
    </tr>
  </tbody>
</table>
<h3>===========================</h3>
</body>
</html>
EOF

else
cat <<EOF >> "$LOGFILE"
<html>
<head><meta http-equiv='refresh' content='30'>
<title>Undervoltage Monitor</title></head>
<body>
<table>
  <tbody>
    <tr>
      <td>Last Updated:</td>
      <td>$(date)</td>
    </tr>
    <tr>
      <td>vcgencmd (throttling status):</td>
      <td>$STATUS</td>
    </tr>
    <tr>
      <td>Temp:</td>
      <td>$TEMP</td>
    </tr>
    <tr>
      <td>free -h (memory):</td>
      <td><pre>$(free -h)</pre></td>
    </tr>
  </tbody>
</table>
<h3>===========================</h3>
</body>
</html>
EOF
fi

