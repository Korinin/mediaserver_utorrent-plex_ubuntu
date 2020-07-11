#!/bin/bash
wget http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-ubuntu-13-04 -O utserver.tar.gz

#32 bits:
#wget http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-i386-ubuntu-13-04 -O utserver.tar.gz
#Once downloaded, change working directory to the directory where uTorrent server file is downloaded. Then run the following command to extract the tar.gz file to /opt/ directory.

sudo tar xvf utserver.tar.gz -C /opt/
#Next, install required dependencies by executing the following command.

sudo apt install libssl1.0.0 libssl-dev -y
#Note that if you are using Ubuntu 19.04, you need to download the libssl1.0.0 deb package from Ubuntu 18.04 repository and install it, because libssl1.0.0 isn’t included in Ubuntu 19.04 software repository.

wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb

sudo apt install ./libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb
#After the dependencies are installed, create a symbolic link.

sudo ln -s /opt/utorrent-server-alpha-v3_3/utserver /usr/bin/utserver
#Use the following command to start uTorrent server. By default, uTorrent server listens on 0.0.0.0:8080. If there’s another service also listens on port 8080, you should temporarily stop that service. uTorrent will also use port 10000 and 6881. The -daemon option will make uTorrent server run in the background.

utserver -settingspath /opt/utorrent-server-alpha-v3_3/ -daemon
#You can now visit the uTorrent web UI in your browser by typing in the following text in the web browser address bar.

#your-server-ip:8080/gui
#If you are installing uTorrent on your local computer, then replace your-server-ip with localhost.

#localhost:8080/gui
#If there’s a firewall on your Ubuntu server, then you need to allow access to port 8080 and 6881. For example, if you are using UFW, then run the following two commands to open port 8080 and 6881.

sudo ufw allow 8080/tcp
sudo ufw allow 6881/tcp

#Please note that /gui is needed in the URL, otherwise you will encounter invalid request error.
# When asked for username and password, enter admin in username field and leave password filed empty.

#uTorrent-ubuntu-18.04

#Once you are logged in, you should change the admin password by clicking the gear icon, then selecting Web UI on the left menu. You can change both the username and password, which is more secure than using admin as the username.

#utorrent-ubuntu-19.04

#If you have other service listening on port 8080, then in the Connectivity section, you can change the uTorrent listening port to other port like 8081.  After changing the port, you must restart uTorrent server with the following commands.

#sudo pkill utserver

#utserver -settingspath /opt/utorrent-server-alpha-v3_3/ &
#You can set default download directory in the Directories tab.