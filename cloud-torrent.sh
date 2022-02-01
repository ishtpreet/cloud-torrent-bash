#! /bin/bash


echo Please enter username: 
read username

echo Please enter PORT Number [3000]: 
read portNumber

if [ ! -n "$portNumber" ]
then
  portNumber=3000
fi

curl https://i.jpillora.com/cloud-torrent! | bash

cat >/etc/systemd/system/cloud-torrent.service <<EOL
[Unit]
Description=cloud-torrent

[Service]
WorkingDirectory=/home/${username}/
ExecStart=/usr/local/bin/cloud-torrent --port ${portNumber} --config-path /home/${username}/cloud-torrent.json --title "Cloud Torrent" --log
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOL

systemctl enable cloud-torrent

systemctl start cloud-torrent

echo Done!
echo Want to check cloud-torrent status [y/N]
read decision

if [[ "$decision" == "y" ]]
then
  systemctl status cloud-torrent
fi
