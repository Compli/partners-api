#!/bin/bash

DEPLOYMENT=$1
AUTH=$2
URL="https://$DEPLOYMENT.compligo.com/api/REST/partners/1.0"
JOB_TITLES='{
  "payload":{
    "client_unique_identifier":"'"$(/dev/urandom | base64)"'",
    "function":"job_titles",
    "data":[
      
    ]
  }
}'

BYTES=$(echo "$JOB_TITLES" | wc -c | xargs)
CONTENT_LENGTH=$(($BYTES - 1))

curl -v "$URL" \
-H "API-Authentication: ${AUTH}" \
-H "Content-Type: application/json" \
-H "Content-Length: ${CONTENT_LENGTH}" \
-X POST \
-d "${JOB_TITLES}" \
