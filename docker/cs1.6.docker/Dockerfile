FROM ubuntu:12.04
EXPOSE 27015 27015
ENV STEAMEXE /home/csserver/steamcmd.sh
RUN apt-get update
RUN apt-get install -qq -y wget && \
    apt-get install -qq -y sudo
RUN apt-get install -qq -y curl
RUN apt-get install -qq -y tmux
RUN apt-get install -qq -y vim
RUN echo "INSTALL MISSING"
RUN apt-get install -qq -y bsdmainutils python 
RUN apt-get install -qq -y bzip2 lib32gcc1 libstdc++6:i386
RUN adduser csserver
RUN wget https://gameservermanagers.com/dl/csserver -O /home/csserver/csserver.sh
ADD ./run_csserver.sh /home/csserver/run_csserver.sh
RUN chown -R csserver /home/csserver
RUN chmod -R 770 /home/csserver
USER csserver
RUN sed -i 's/ip="0.0.0.0"/ip="144.76.91.19"/g' /home/csserver/csserver.sh
RUN /home/csserver/csserver.sh auto-install
ADD cs-server.cfg /home/csserver/serverfiles/cstrike/cs-server.cfg
ADD maps /home/csserver/serverfiles/cstrike/maps
USER root
RUN chown csserver /home/csserver/serverfiles/cstrike/cs-server.cfg
RUN chmod 770 /home/csserver/serverfiles/cstrike/cs-server.cfg
USER csserver
RUN sed -i 's/ip="144.76.91.19"/ip="0.0.0.0"/g' /home/csserver/csserver.sh
ENTRYPOINT /home/csserver/run_csserver.sh
