#!/bin/bash

ring cs --instance cs_instance jdbc pools --name common set-params --url jdbc:postgresql://$POSTGRES_URL?currentSchema=public
ring cs --instance cs_instance jdbc pools --name common set-params --username $POSTGRES_USER
ring cs --instance cs_instance jdbc pools --name common set-params --password $POSTGRES_PASSWORD
ring cs --instance cs_instance jdbc pools --name privileged set-params --url jdbc:postgresql://$POSTGRES_URL?currentSchema=public
ring cs --instance cs_instance jdbc pools --name privileged set-params --username $POSTGRES_USER
ring cs --instance cs_instance jdbc pools --name privileged set-params --password $POSTGRES_PASSWORD


ring cs --instance cs_instance websocket set-params --hostname 0.0.0.0
ring cs --instance cs_instance websocket set-params --port 8181

ring hazelcast --instance hc_instance service start
ring elasticsearch --instance elastic_instance service start
ring cs --instance cs_instance service start

sleep 30

curl -Sf -X POST -H "Content-Type: application/json" \
-d "{ \"url\" : \"jdbc:postgresql://$POSTGRES_URL\", \"username\" : \"$POSTGRES_USER\", \"password\" : \"$POSTGRES_PASSWORD\", \"enabled\" : true }" -u admin:admin http://localhost:8087/admin/bucket_server