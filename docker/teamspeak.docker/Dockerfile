FROM ubuntu:14.04
RUN sudo apt-get update
RUN sudo apt-get install -q -yy wget
RUN sudo adduser teamspeak --system --home /usr/local/bin/teamspeak3-server_linux_amd64 --disabled-login && \
    sudo su teamspeak --shell /bin/bash && \
    wget http://dl.4players.de/ts/releases/3.0.13/teamspeak3-server_linux_amd64-3.0.13.tar.bz2 -O /tmp/ts-server-software.tar.bz2
RUN tar --verbose -xjf /tmp/ts-server-software.tar.bz2 -C /usr/bin/
RUN rm /tmp/ts-server-software.tar.bz2
ADD ./config-files /home/teamspeak
ADD start_teamspeak.sh /home/teamspeak
RUN chmod 755 /home/teamspeak/start_teamspeak.sh


