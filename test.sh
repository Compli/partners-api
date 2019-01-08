#!/bin/bash

DEPLOYMENT=$1
AUTH=$2
#URL="https://complicontroller.onmats.com/api/REST/get_host_name/1.3"
URL="https://complicontroller.onmats.com/api/REST/get_host/1.0"
JOB_TITLES='{
  "payload":{
    "client_unique_identifier":"'"$(echo -n /dev/urandom | base64)"'",
    "function":"get_host,
    "data":[
      {"deployment":"'"$1"'"}
    ]
  }
}'
echo "$JOB_TITLES"
BYTES=$(echo "$JOB_TITLES" | wc -c | xargs)
CONTENT_LENGTH=$(($BYTES - 1))
echo "$CONTENT_LENGTH"
curl -v "$URL" \
-H "API-Authentication: ${AUTH}" \
-H "Content-Type: application/json" \
-H "Content-Length: ${CONTENT_LENGTH}" \
-X POST \
-d "${JOB_TITLES}" \
