FROM ubuntu:12.04
EXPOSE 27015 27015
EXPOSE 22 22
ENV STEAMEXE /home/csserver/steamcmd.sh
RUN apt-get update
RUN apt-get install -qq -y wget && \
    apt-get install -qq -y sudo
RUN apt-get install -qq -y curl
RUN apt-get install -qq -y tmux
RUN apt-get install -qq -y vim
RUN apt-get install -qq -y openssh-server
RUN echo "INSTALL MISSING"
RUN apt-get install -qq -y bsdmainutils python 
RUN apt-get install -qq -y bzip2 lib32gcc1 libstdc++6:i386
RUN adduser csserver
RUN chown -R csserver /home/csserver
RUN chmod -R 770 /home/csserver
USER csserver
RUN cd /home/csserver && wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh csserver
ADD ./run_csserver.sh /home/csserver/run_csserver.sh
RUN /home/csserver/csserver auto-install
ADD cs-server.cfg /home/csserver/serverfiles/cstrike/cs-server.cfg
USER root
RUN chown csserver /home/csserver/serverfiles/cstrike/cs-server.cfg
RUN chmod 770 /home/csserver/serverfiles/cstrike/cs-server.cfg
RUN mkdir /var/run/sshd
CMD /usr/sbin/sshd && su -c "/home/csserver/run_csserver.sh" csserver
