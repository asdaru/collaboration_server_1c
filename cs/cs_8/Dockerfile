# Сервер взаимодействия 1С 8.3
# https://its.1c.ru/db/v8311doc/content/232/hdoc


FROM debian:stretch-slim
MAINTAINER asda.ru (Andrey Mamaev)

RUN mkdir -p /usr/share/man/man1 && \
	apt-get update && apt-get install -y \
	wget curl openjdk-8-jdk sudo

ADD dist /opt/dist
RUN cd /opt/dist \
	&& dpkg -i *.deb && rm -rf *

RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
		
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin:/opt/1C/1CE/x86_64/ring

RUN mkdir -p /var/cs/cs_instance && \
	mkdir -p /var/cs/hc_instance && \
	mkdir -p /var/cs/elastic_instance && \
	chmod +x /opt/1C/1CE/x86_64/ring/ring && \
	export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
RUN ring cs instance create --dir /var/cs/cs_instance --owner root 
RUN ring cs --instance cs_instance service create --username root --stopped --java-home $JAVA_HOME
RUN ring hazelcast instance create --dir /var/cs/hc_instance --owner root && \
	ring hazelcast --instance hc_instance service create --username root --stopped --java-home $JAVA_HOME
RUN ring elasticsearch instance create --dir /var/cs/elastic_instance --owner root && \
	ring elasticsearch --instance elastic_instance service create --username root --stopped --java-home $JAVA_HOME

COPY run.sh /
COPY init.sh /
COPY restart.sh /
RUN chmod +x /*.sh

ENV POSTGRES_URL "postgres:5432/cs"
ENV POSTGRES_USER "postgres"
ENV POSTGRES_PASSWORD "postgres"

EXPOSE 8181

CMD ["/run.sh"]
