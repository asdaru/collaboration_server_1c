#!/bin/bash
sleep 10
ring hazelcast --instance hc_instance service stop
ring elasticsearch --instance elastic_instance service stop
ring cs --instance cs_instance service stop

sleep 15

ring hazelcast --instance hc_instance service start
sleep 1
ring elasticsearch --instance elastic_instance service start
sleep 1
ring cs --instance cs_instance service start
