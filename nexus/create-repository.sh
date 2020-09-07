#!/bin/bash

host=$1
port=$2
user=$3
pw=$4

for jsonFile in ./rep/*
do
 
    repType=$(cat $jsonFile  | jq -r '.repType')
    repSubType=$(cat $jsonFile  | jq -r '.repSubType')

    printf "Creating Integration API Script from $jsonFile\n\n"

    curl -v -u $user:$pw --header "Content-Type: application/json" "http://$host:$port/service/rest/v1/repositories/$repType/$repSubType" -d @$jsonFile
done

