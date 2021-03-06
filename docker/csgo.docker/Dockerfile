#
# CSGO Dockerfile
#
# https://hub.docker.com/r/austinsaintaubin/docker-csgoserver/
# Also see: https://hub.docker.com/r/johnjelinek/csgoserver/~/dockerfile/

# Pull the base image
FROM ubuntu:12.04
MAINTAINER Austin St. Aubin <AustinSaintAubin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

#### Variables ####
ENV SERVER_NAME "Lame Name - Counter Strike: Global Offensive"
ENV RCON_PASS Birnensaft100Ml
ENV SERVER_PASS "lame"
ENV SERVER_LAN 0
ENV SERVER_REGION 3

# Notification Email
# (on|off)
ENV EMAIL_NOTIFICATION off
ENV EMAIL dennis.nikolay@gmx.de

# STEAM LOGIN
ENV STEAM_USER dennis_snake_gast
ENV STEAM_PASS ""

# Start Variables
# https://developer.valvesoftware.com/wiki/Counter-Strike:_Global_Offensive_Dedicated_Servers#Starting_the_Server
# [Game Modes]           gametype    gamemode
# Arms Race                  1            0
# Classic Casual             0            0
# Classic Competitive        0            1
# Demolition                 1            1
# Deathmatch                 1            2
ENV GAME_MODE 1
ENV GAME_TYPE 0
ENV DEFAULT_MAP de_dust2
ENV MAP_GROUP random_classic
ENV MAX_PLAYERS 20
ENV TICK_RATE 128
ENV GAME_PORT 27015
ENV SOURCE_TV_PORT 27020
ENV CLIENT_PORT 27005
ENV GAME_IP 0.0.0.0
ENV UPDATE_ON_START off
ENV GSLT "A2DDBB58121972F629D2702CD31746D9"

# Optional: Workshop Parameters
# https://developer.valvesoftware.com/wiki/CSGO_Workshop_For_Server_Operators
# To get an authkey visit - http://steamcommunity.com/dev/apikey
ENV AUTH_KEY "3EAD6F2AED0CF979740C762A5AAB9E9B"
ENV WS_COLLECTION_ID ""
ENV WS_START_MAP ""

# Expose Ports
EXPOSE $GAME_PORT
EXPOSE $GAME_PORT/udp
EXPOSE $SOURCE_TV_PORT/udp
EXPOSE $CLIENT_PORT/udp
#EXPOSE 1200/udp

# Install Packages / Dependencies
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -qqy wget nano tmux mailutils postfix lib32gcc1 \
                         gdb ca-certificates bsdmainutils

#FIX
RUN apt-get install -qq -y curl
RUN apt-get install -qq -y bsdmainutils python
RUN apt-get install -qq -y bzip2 lib32gcc1 libstdc++6:i386
RUN apt-get install -qq -y sudo vim

# Install Postfix Package OR https://hub.docker.com/r/catatnight/postfix/

# FIX ( perl: warning: Please check that your locale settings: )
# http://ubuntuforums.org/showthread.php?t=1346581
RUN locale-gen en_US en_US.UTF-8 hu_HU hu_HU.UTF-8
RUN dpkg-reconfigure locales

# # Cleanup
# RUN apt-get clean && \
#     rm -fr /var/lib/apt/lists/* && \
#     rm -fr /tmp/*

# Create softlink for script (Downloaded Later), this will allow ENTRYPOINT to find the script ( endpoint runs in /root/ )
# RUN ln -s "/home/csgoserver/csgoserver" "/root/csgoserver"

ADD serverfiles /home/csgoserver/serverfiles

# Create user to run as
# script refuses to run in root, create user
RUN groupadd -r csgoserver && \
	useradd -rm -g csgoserver csgoserver && \
	adduser csgoserver sudo && \
	echo "csgoserver ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
WORKDIR /home/csgoserver


RUN chown -R csgoserver:csgoserver /home/csgoserver
RUN chmod -R 770 /home/csgoserver
#VOLUME ["/home/csgoserver/serverfiles
USER csgoserver

# Download CSGO Server Manager Script
# https://raw.githubusercontent.com/dgibbs64/linuxgameservers/master/CounterStrikeGlobalOffensive/csgoserver
RUN wget http://gameservermanagers.com/dl/csgoserver && \
    chmod +x csgoserver

# Install Metamod
RUN wget -O /home/csgoserver/metamod.tar.gz http://mirror.pointysoftware.net/alliedmodders/mmsource-1.10.6-linux.tar.gz
RUN tar zxvf metamod.tar.gz -C /home/csgoserver/serverfiles/csgo

#Install Sourcemod
RUN wget -O /home/csgoserver/sourcemod.tar.gz http://www.sourcemod.net/smdrop/1.8/sourcemod-1.8.0-git5929-linux.tar.gz
RUN tar zxvf sourcemod.tar.gz -C /home/csgoserver/serverfiles/csgo

# Edit Server Script to hold Docker Environmental Varables
RUN sed -i '/emailnotification=/s/"\([^"]*\)"/"$EMAIL_NOTIFICATION"/' csgoserver && \
    sed -i '/email=/s/"\([^"]*\)"/"$EMAIL"/' csgoserver && \
    sed -i '/steamuser=/s/"\([^"]*\)"/"$STEAM_USER"/' csgoserver && \
    sed -i '/steampass=/s/"\([^"]*\)"/"$STEAM_PASS"/' csgoserver && \
    sed -i '/gamemode=/s/"\([^"]*\)"/"$GAME_MODE"/' csgoserver && \
    sed -i '/gametype=/s/"\([^"]*\)"/"$GAME_TYPE"/' csgoserver && \
    sed -i '/defaultmap=/s/"\([^"]*\)"/"$DEFAULT_MAP"/' csgoserver && \
    sed -i '/mapgroup=/s/"\([^"]*\)"/"$MAP_GROUP"/' csgoserver && \
    sed -i '/maxplayers=/s/"\([^"]*\)"/"$MAX_PLAYERS"/' csgoserver && \
    sed -i '/tickrate=/s/"\([^"]*\)"/"$TICK_RATE"/' csgoserver && \
    sed -i '/port=/s/"\([^"]*\)"/"$GAME_PORT"/' csgoserver && \
    sed -i '/sourcetvport=/s/"\([^"]*\)"/"$SOURCE_TV_PORT"/' csgoserver && \
    sed -i '/clientport=/s/"\([^"]*\)"/"$CLIENT_PORT"/' csgoserver && \
    sed -i '/ip=/s/"\([^"]*\)"/"$GAME_IP"/' csgoserver && \
    sed -i '/updateonstart=/s/"\([^"]*\)"/"$UPDATE_ON_START"/' csgoserver && \
    sed -i '/authkey=/s/"\([^"]*\)"/"$AUTH_KEY"/' csgoserver && \
    sed -i '/ws_collection_id=/s/"\([^"]*\)"/"$WS_COLLECTION_ID"/' csgoserver && \
    sed -i '/ws_start_map=/s/"\([^"]*\)"/"$WS_START_MAP"/' csgoserver && \
    sed -i '/gslt=/s/"\([^"]*\)"/"$GSLT"/' csgoserver
# RUN cat csgoserver  # DEBUG

# Run Install Script
#RUN ./csgoserver auto-install
ADD serverfiles /home/csgoserver/serverfiles
USER root
RUN chown -R csgoserver:csgoserver /home/csgoserver/serverfiles && \
    chmod -R 770 /home/csgoserver/serverfiles
USER csgoserver
# Run Start Script
# https://labs.ctl.io/dockerfile-entrypoint-vs-cmd/
# http://stackoverflow.com/questions/21553353/what-is-the-difference-between-cmd-and-entrypoint-in-a-dockerfile
# http://kimh.github.io/blog/en/docker/gotchas-in-writing-dockerfile-en/
# http://www.markbetz.net/2014/03/17/docker-run-startup-scripts-then-exit-to-a-shell/
# http://crosbymichael.com/dockerfile-best-practices.html
# https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/
# ENTRYPOINT ["./csgoserver"]  # does not work the way I want to.
# CMD ["/bin/bash", "-c", "set -e && /home/csgoserver/start.sh"]  # DOES NOT STAY RUNNING.
CMD bash -c './csgoserver auto-install;rm /home/csgoserver/serverfiles/csgo/cfg/csgo-server.cfg; cp /home/csgoserver/serverfiles/csgo/cfg/csgo-server.cfg.default /home/csgoserver/serverfiles/csgo/cfg/csgo-server.cfg; exec echo "y\n"  | /home/csgoserver/csgoserver debug';
