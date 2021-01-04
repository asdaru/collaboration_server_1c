FROM bellsoft/liberica-openjdk-debian:11

RUN apt-get update && apt-get install -y \
	wget curl

ADD dist /opt/dist

RUN cd /opt/dist \
	&& dpkg -i *.deb && rm -rf *

RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
