# Сервер взаимодействия 1С 8.3
#https://its.1c.ru/db/v8311doc/content/232/hdoc


FROM debian:bullseye-slim



RUN mkdir -p /usr/share/man/man1 && \
	apt-get update && apt-get install -y \
	wget curl sudo gawk

RUN mkdir -p /opt/dist && cd /opt/dist \
	&& wget https://download.bell-sw.com/java/11.0.14+9/bellsoft-jdk11.0.14+9-linux-amd64.deb \
	&& wget http://casa.ru/collaborationserver1c/1c_cs_11.0.25_linux_x86_64.tar.gz --no-check-certificate 

RUN cd /opt/dist \
	&& tar xzf 1c_cs_11.0.25_linux_x86_64.tar.gz \
	&& dpkg -i bellsoft-jdk11.0.14+9-linux-amd64.deb;  apt-get -f install -y \
	&& dpkg -i *.deb \
	&& ls /opt/dist \
	&& ./1ce-installer-cli install \
	&& rm -rf * 


RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
		
ENV JAVA_HOME /usr/lib/jvm/bellsoft-java11-amd64
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin:/opt/1C/1CE/components/1c-enterprise-ring-0.19.5+12-x86_64/


RUN mkdir -p /var/cs/cs_instance && \
	mkdir -p /var/cs/hc_instance && \
	mkdir -p /var/cs/elastic_instance \
	&& chmod +x /opt/1C/1CE/components/1c-enterprise-ring-0.19.5+12-x86_64/ring 

RUN ring cs instance create --dir /var/cs/cs_instance --owner root \
	&& ring hazelcast instance create --dir /var/cs/hc_instance --owner root \
	&& ring elasticsearch instance create --dir /var/cs/elastic_instance --owner root

#Сервис сыпется на pidof это такой дурацкйи костыль
RUN mv /bin/pidof /bin/_pidof && cp /bin/echo /bin/pidof 

RUN ring hazelcast --instance hc_instance service create --username root --stopped --java-home $JAVA_HOME 
RUN ring elasticsearch --instance elastic_instance service create --username root --stopped --java-home $JAVA_HOME
RUN ring cs --instance cs_instance service create --username root --stopped --java-home $JAVA_HOME

#RUN mv /bin/_pidof /bin/pidof

COPY run.sh /
COPY init.sh /
COPY restart.sh /
RUN chmod +x /*.sh

ENV POSTGRES_URL "postgres:5432/cs"
ENV POSTGRES_USER "postgres"
ENV POSTGRES_PASSWORD "postgres"

EXPOSE 8181
CMD ["/run.sh"]
