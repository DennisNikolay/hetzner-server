#!/usr/bin/env bash
/usr/bin/teamspeak3-server_linux_amd64/ts3server_startscript.sh start inifile=/home/teamspeak/config/ts3server.ini
sleep 10
tail -f /home/teamspeak/logs/ts3server_1.log