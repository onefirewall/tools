#!/bin/bash

days_to_remove=30
index_name=poc_traffic
elastic_hostname=localhost


deleting_window=$(($days_to_remove+1))
t0=$(date --date="$deleting_window days ago" +"%Y-%m-%dT%H:%M:%S.000Z")
t1=$(date --date="$days_to_remove days ago" +"%Y-%m-%dT%H:%M:%S.000Z")

echo $t0
echo $t1

curl -X POST "http://$elastic_hostname:9200/$index_name/_delete_by_query" -i -H "Content-Type: application/json" -d '
 {
  "query" : {
    "range" : {
        "timestamp" : { "gte" : "'$t0'", "lt" : "'$t1'"}
    }
  }
}'

echo 
echo "--"
echo