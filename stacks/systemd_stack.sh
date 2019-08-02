#!/bin/bash

echo Script name: $0
echo $# arguments

if [ "$#" -ne 1 ]; then
    echo "Invalid number of parameters. 1 parameter required, must be name of template stack"
fi

echo "writing docker-compose service to /etc/systemd/system/docker-compose-${1}.service"

# ensure that the folder exists.
cd ${1}

CURRENT_WORKING_DIR=`pwd`

cat << EOM > /etc/systemd/system/docker-compose-${1}.service
[Unit]
Description=${1} Stack
After=docker.service
Requires=docker.service

[Service]
Restart=always
EnvironmentFile=-/etc/sysconfig/mediadepot
TimeoutStartSec=0
Restart=always
WorkingDirectory=${CURRENT_WORKING_DIR}
ExecStartPre=-/usr/bin/docker-compose down -v
ExecStartPre=-/usr/bin/docker-compose rm -v
ExecStartPre=-/usr/bin/docker-compose pull
ExecStart=/usr/bin/docker-compose up
ExecStop=/usr/bin/docker-compose down -v

[Install]
WantedBy=multi-user.target
WantedBy=docker.service
EOM

systemctl start docker-compose-${1}.service
systemctl enable docker-compose-${1}.service
systemctl daemon-reload
