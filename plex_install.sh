#!/bin/bash
#To enable the Plex Media Server repository on Ubuntu only a few terminal commands are required. From a terminal window run the following two commands:
# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
   echo 'Please run with sudo or as root.'
   exit 1
fi

apt-get update
apt install curl -y
echo deb https://downloads.plex.tv/repo/deb public main | tee /etc/apt/sources.list.d/plexmediaserver.list
curl https://downloads.plex.tv/plex-keys/PlexSign.key | apt-key add -
#After that, it’s just a matter of running the normal sudo apt-get update and the Plex Media Server repo will be enabled on the OS.
apt-get update
apt install plexmediaserver -y
systemctl status plexmediaserver

mkdir -p /moviesInDo

mkdir /home/video

mkdir /home/music
chown -R plex:plex /home/video
chown -R plex:plex /home/music
chown -R plex:plex /moviesInDo
#Note that if Plex is installed on a remote Ubuntu 18.04 server, you need to set up a SSH tunnel by executing the following command on your local computer. Replace 12.34.56.78 with the IP address of the remote Ubuntu server.

#ssh 12.34.56.78 -L 8888:localhost:32400
#Then you can access Plex web interface via the following URL.

#http://localhost:8888/web