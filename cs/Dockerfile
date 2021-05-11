# Collaboration server version 9+

FROM bellsoft/liberica-openjdk-debian:11

ADD dist /opt/dist
ADD scripts /opt/scripts

# Install collaboration server

RUN cd /opt/dist && tar -xf ./*.gz && \
    chmod +x ./1ce-installer-cli && \
    ./1ce-installer-cli install

RUN cd /opt/scripts && \
    cp ./ring.sh /bin/ring && \
    chmod +x /bin/ring && \
    cp ./run.sh /bin/run_cs && \
    chmod +x /bin/run_cs

RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/dist/*

# Install and create services

RUN ring hazelcast instance create --dir /var/opt/cs/hazelcast && \
    ring elasticsearch instance create --dir /var/opt/cs/elasticsearch && \
    ring cs instance create --dir /var/opt/cs/cs

RUN ring hazelcast --instance hazelcast service create --init-system sysv --stopped --java-home $JAVA_HOME && \
    ring elasticsearch --instance elasticsearch service create --init-system sysv --stopped --java-home $JAVA_HOME && \
    ring cs --instance cs service create --init-system sysv --stopped --java-home $JAVA_HOME

ARG PG_BD
ARG PG_USER
ARG PG_PWD

ARG POSTGRES_URL="postgres:5432/${PG_BD}"
ARG POSTGRES_USER=${PG_USER}
ENV POSTGRES_PASSWORD=${PG_PWD}

EXPOSE 9094

ENTRYPOINT [ "run_cs" ]

# DEBUG
#CMD [ "/bin/bash", "-c",  "while true; do sleep 10; date; done"]

