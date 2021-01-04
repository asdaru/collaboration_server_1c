#!/bin/bash

/init.sh

#======== DELETE INIT CODE ==
sed -i "s/^\/init.sh//" /run.sh

/restart.sh

echo "server started"
while true; do sleep 300; done;