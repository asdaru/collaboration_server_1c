#!/bin/bash

ring cs --instance cs_instance jdbc set-params --url jdbc:postgresql://$POSTGRES_URL?currentSchema=public
ring cs --instance cs_instance jdbc set-params --username $POSTGRES_USER
ring cs --instance cs_instance jdbc set-params --password $POSTGRES_PASSWORD
ring cs --instance cs_instance jdbc-privileged set-params --url jdbc:postgresql://$POSTGRES_URL?currentSchema=public
ring cs --instance cs_instance jdbc-privileged set-params --username $POSTGRES_USER
ring cs --instance cs_instance jdbc-privileged set-params --password $POSTGRES_PASSWORD


ring cs --instance cs_instance websocket set-params --hostname 0.0.0.0
ring cs --instance cs_instance websocket set-params --port 8181

ring hazelcast --instance hc_instance service start
ring elasticsearch --instance elastic_instance service start
ring cs --instance cs_instance service start

/init.sh

#======== DELETE INIT CODE ==
sed -i "s/^\/init.sh//" /run.sh