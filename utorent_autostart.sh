#!/bin/bash
# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with sudo or as root.'
   exit 1
fi

#Put the following text into the file. Note that since we are going to use systemd to start uTorrent, we don’t need the -daemon option in the start command.
sudo cat << EOF > /etc/systemd/system/utserver.service
[Unit]
Description=uTorrent Server
After=network.target

[Service]
Type=simple
User=utorrent
Group=utorrent
ExecStart=/usr/bin/utserver -settingspath /opt/utorrent-server-alpha-v3_3/
ExecStop=/usr/bin/pkill utserver
Restart=always
SyslogIdentifier=uTorrent Server

[Install]
WantedBy=multi-user.target
EOF
#Press Ctrl+O, then press Enter to save the file. Press Ctrl+X to exit. Then reload systemd.

systemctl daemon-reload
#It’s not recommended to run uTorrent server as root, so we’ve specified in the service file that uTorrent server should run as the utorrent user and group, which have no root privileges. Create the utorrent system user and group with the following command.

adduser --system utorrent

addgroup --system utorrent
#Add the utorrent user to the utorrent group.

adduser utorrent utorrent
#Next, Stop the current uTorrent server.

pkill utserver
#Use the systemd service to start uTorrent server.

systemctl start utserver
#Enable auto start at boot time.

systemctl enable utserver
#Now check utserver status.

systemctl status utserver
#auto-start-utorrent-server-ubuntu-18.04

#We can see that auto start is enabled and uTorrent server is running. When creating the utorrent user, a home directory was also created at /home/utorrent/. It’s recommended that you set this home directory as your torrent download directory because the utorrent user has write permission. We also need to make utorrent as the owner of the /opt/utorrent-server-alpha-v3_3/ directory by executing the following command.

chown utorrent:utorrent /opt/utorrent-server-alpha-v3_3/ -R
#Note: The remaining content is for people who has basic knowledge about web server and DNS records. If you don’t know what Apache/Nginx or DNS A record is, you don’t have to follow the instructions below.