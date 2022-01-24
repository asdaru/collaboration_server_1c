#!/bin/bash
#======== RUN and DELETE INIT CODE ==
/init.sh && sed -i "s/^\/init.sh.*/\/restart.sh/" /run.sh

echo "start ok"
while true; do sleep 600; done;