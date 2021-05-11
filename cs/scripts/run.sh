#!/bin/bash

echo "Restarting services..."

ring hazelcast --instance hazelcast service stop --init-system sysv
ring elasticsearch --instance elasticsearch service stop --init-system sysv
ring cs --instance cs service stop --init-system sysv

sleep 5

ring hazelcast --instance hazelcast service start --init-system sysv
ring elasticsearch --instance elasticsearch service start --init-system sysv
ring cs --instance cs service start --init-system sysv

echo "Services started..."

done=0
trap 'done=1' TERM INT

while [ $done = 0 ]; do
  sleep 10 &
  wait
done