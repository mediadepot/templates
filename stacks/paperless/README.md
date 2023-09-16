# Background Export Task

`/etc/systemd/system/paperless-export.service`

```systemd
[Unit]
Description="paperless export utility - https://docs.paperless-ngx.com/administration/#exporter"
After=docker.service
Requires=docker.service

[Service]
ExecStart=/usr/bin/docker exec paperless_webserver_1 document_exporter /usr/src/paperless/export

[Install]
WantedBy=multi-user.target
WantedBy=docker.service
```

`/etc/systemd/system/paperless-export.timer`

```
[Unit]
Description="paperless export utility - https://docs.paperless-ngx.com/administration/#exporter"

[Timer]
OnBootSec=15min
OnUnitActiveSec=24h
OnCalendar=daily

[Install]
WantedBy=multi-user.target
```


# Commands

- `systemctl reenable paperless-export.service`
- `systemctl reenable paperless-export.timer`
- `systemctl start paperless-export.timer`
- `systemctl list-timers`
