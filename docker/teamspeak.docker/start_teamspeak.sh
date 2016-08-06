#!/usr/bin/env bash
su teamspeak
/usr/bin/teamspeak3-server_linux_amd64/ts3server_startscript.sh start inifile=/home/teamspeak/ts3server.ini
sleep 10
tail /home/teamspeak/server/logs/ts3server_0.log