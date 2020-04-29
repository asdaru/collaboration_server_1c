#!/bin/bash
#useradd cs_user
curl -Sf -X POST -H "Content-Type: application/json" \
-d "{ \"url\" : \"jdbc:postgresql://$POSTGRES_URL\", \"username\" : \"$POSTGRES_USER\", \"password\" : \"$POSTGRES_PASSWORD\", \"enabled\" : true }" -u admin:admin http://localhost:8087/admin/bucket_server