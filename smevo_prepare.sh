#!/bin/bash
sudo mkdir -p /usr/app/smevo
sudo chown $USER:$USER /usr/app/smevo
#curl -fsSL https://get.docker.com -o get-docker.sh
#sudo sh get-docker.sh
sudo gpasswd -a $USER docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /us>
sudo chmod +x /usr/local/bin/docker-compose
sudo cat << EOF > /etc/systemd/system/docker-compose-app.service
[Unit]
Description=Docker Compose Application Service
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/usr/app/smevo
ExecStart=/usr/local/bin/docker-compose -f /usr/app/smevo-app.yml -p smevo up -d
ExecStop=/usr/local/bin/docker-compose -f /usr/app/smevo-app.yml -p smevo down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
EOF

systemctl enable docker-compose-app

git clone https://github.com/variusgc/smevo-deploy.git /usr/app/smevo

docker network create smevo
docker login -u variusgc
docker pull variusgc/smevo-app
docker pull variusgc/smevo-node
cd /usr/app/smevo
#sudo systemctl start docker-compose-app
