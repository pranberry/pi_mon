# Script and systemD files for monitoring pi

## Why?

- Periodically, Pi would become unresponsive (no writes, no ssh, no mdns, etc). Figured some event occurs and the ssd enclosure's power draw increases and I lose write access. This scrip setup is to monitor that

## Setup

- Create the following dirs+files and emable systemD service

```bash
touch /dev/shm/undervolt.html
mkdir -p /opt/pi_monitor/
cp pi_mon.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now pi_mon.service
```

- Note: log file is in /dev/shm/ because service needs to keep logging after system goes write only. shm is in RAM