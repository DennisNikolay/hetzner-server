FROM ubuntu:14.04
EXPOSE 9987 30033 10011
VOLUME /home/teamspeak/config
RUN sudo apt-get update
RUN sudo apt-get install -q -yy wget vim
RUN sudo adduser teamspeak --system --home /usr/local/bin/teamspeak3-server_linux_amd64 --disabled-login && \
    wget http://dl.4players.de/ts/releases/3.0.13/teamspeak3-server_linux_amd64-3.0.13.tar.bz2 -O /tmp/ts-server-software.tar.bz2
RUN tar --verbose -xjf /tmp/ts-server-software.tar.bz2 -C /usr/bin/
RUN rm /tmp/ts-server-software.tar.bz2
ADD start_teamspeak.sh /home/teamspeak
RUN chown -R teamspeak /home/teamspeak
RUN chmod -R 770 /home/teamspeak
RUN chown -R teamspeak /usr/local/bin/teamspeak3-server_linux_amd64
RUN chmod -R 770 /usr/local/bin/teamspeak3-server_linux_amd64
USER teamspeak
ENTRYPOINT /home/teamspeak/start_teamspeak.sh

