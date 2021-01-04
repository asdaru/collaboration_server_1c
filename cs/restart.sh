#!/bin/bash
ring hazelcast --instance hc_instance service stop
ring elasticsearch --instance elastic_instance service stop
ring cs --instance cs_instance service stop

sleep 5

ring hazelcast --instance hc_instance service start
ring elasticsearch --instance elastic_instance service start
ring cs --instance cs_instance service start
