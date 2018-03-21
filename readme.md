# Partners API

## Prequisets

To use the partners API, you must have the following:

- `deployment-name`: The name of the compligo site.  The deployment-name is also the compligo subdomain (`https://companyname.compligo.com`).
- `Auth Token`: The token that must be passed in the request header to authenticate a request. 

## Endpoint

URL: `https://<deployment-name>.compligo.com/api/REST/partners/1.0`

Method: `POST`

Data Format: `JSON`

## Making a Request

The code snippet below shows how to make a request with Bash/cURL.  Notice that the property `client_unique_identifier` is auto-generated.
A unique identifier may only be used once.  This may be used for client-side idempotency. 

```sh
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
```

To Run:

```sh
chmod +x partners_api_example.sh
./partners_api_example.sh <deployment-name> <auth-token>
```

# API Functions

All API functions below are available on the partners API endpoint.  Functions are accessed by specifying the desired function in the `funtion` parameter of the `payload` object.

## Search

Search functions allow you to search for data used to create new personnel records in Compligo.  Example headers and payloads are shown below.

### job_titles

Example Request:

```
POST https://<deployment-name>/api/REST/partners/1.0 HTTP/1.1
API-Authentication: [Token hidden]
Content-Type: application/json

{
  "payload":{
    "client_unique_identifier":"5fd9dc70adf47b6cafc1f7f48a1e8421",
    "function":"job_titles",
    "data":[
      
    ]
  }
}
```

Example Response:

```
{
  "payload":{
    "client_unique_identifier":"797a436b00b3b6a5eeca9e2776138c8c",
    "result":"success",
    "error_code":null,
    "error_desc":null,
    "warnings":[
      
    ],
    "data":[
      {
        "_job_title":"Text",
        "_job_code":"Some Text"
      },
      {
        "_job_title":"Text",
        "_job_code":"Some Text"
      },
      {
        "_job_title":"Text",
        "_job_code":"Some Text"
      },
      {
        "_job_title":"Text",
        "_job_code":"Some Text"
      }
    ]
  }
}
```

### locations

Example Request:

```
POST https://<deployment-name>/api/REST/partners/1.0 HTTP/1.1
API-Authentication: [Token hidden]
Content-Type: application/json

{
  "payload":{
    "client_unique_identifier":"d9b5123ddc5eb8a1324494409ff33272",
    "function":"locations",
    "data":[
      
    ]
  }
}
```

Example Response:

```
{
  "payload":{
    "client_unique_identifier":"c84b5657c60b19b0988278cfbb314a8c",
    "result":"success",
    "error_code":null,
    "error_desc":null,
    "warnings":[
      
    ],
    "data":[
      {
        "_location_id":"Some Text",
        "_location_type":2980,
        "_location_name":"Text"
      },
      {
        "_location_id":"Some Text",
        "_location_type":2980,
        "_location_name":"Text"
      },
      {
        "_location_id":"Some Text",
        "_location_type":2980,
        "_location_name":"Text"
      }
    ]
  }
}
```

### supervisors

Example Request:

```
POST https://<deployment-name>/api/REST/partners/1.0 HTTP/1.1
API-Authentication: [Token hidden]
Content-Type: application/json

{
  "payload":{
    "client_unique_identifier":"4f8b15a65a9ac850c0809c4fffc13c64",
    "function":"locations",
    "data":[
      
    ]
  }
}
```

Example Response:

```
{
  "payload":{
    "client_unique_identifier":"12e37410957e83ed7d969d1ec1027b3e",
    "result":"success",
    "error_code":null,
    "error_desc":null,
    "warnings":[
      
    ],
    "data":[
      {
        "first_name":"Text",
        "last_name":"Text",
        "employee_number":"1234"
      }
    ]
  }
}
```

## Create

### create_personnel

#### Workflow

The general workflow for adding a new personnel record is:

1. Request a current list of `job_titles`, `locations`, and `supervisors` using the functions above.
1. Allow end user to select which job title, location, and supervisor to use.
1. Build `create_personnel` with selected options plus all required fields and any optional fields.
1. Send request.
1. Verify response.

#### Properties

The following properties may be passed to the `create_personnel` endpoint.  Fields noted as required are required.  Fields with examples much match the provided example.  Fields with no type specified must contain the values shown below.

`first_name` _string_ **REQUIRED**

`last_name` _string_ **REQUIRED**

`title` _string_ **REQUIRED**

`location` _string_ **MUST MATCH EXISTING**

`employee_status` _string_ **MUST MATCH EXISTING** (Recomend using "Active")

`supervisor_first_name` _string_ **MUST MATCH EXISTING**

`supervisor_last_name` _string_ **MUST MATCH EXISTING**

`username` _string_ *REQUIRED*

`type` _integer_ **MUST MATCH EXISTING** (Recomend using "Employee")

`employment_classification` _string_ **MUST MATCH EXISTING** (Choose from "Full Time", "Part Time", "Seasonal", "Temporary")

`employee_number` _int_

`supervisor_employee_number` _int_ **MUST MATCH EXISTING**

`hire_date` _sting_ **(mm/dd/yyyy)**

`work_email` _string_

`personal_email` _string_

`termination_date` _string_ **(mm\/dd\/yyyy)**

`middle_name` _string_

`ssn` _string_ *111-11-1111*

`dob` _string_ *mm\/dd\/yyyy*

`address` _string_

`city` _string_

`home_state_province` _string_ **MUST MATCH EXISTING**

`zip_code` _string_ **12345-6789**

`country` _string_ **MUST MATCH EXISTING**

`mobile_phone` _string_

`home_phone` _string_

`work_phone` _string_

`drivers_license_number` _string_

`drivers_license_state` _string_ **MUST MATCH EXISTING**

`drivers_license_expiration_date` _string_ **mm\/dd\/yyyy**

Example Request:

```
POST https://<deployment-name>.com/api/REST/partners/1.0 HTTP/1.1
API-Authentication: [Token hidden]
Content-Type: application/json

{
  "payload":{
    "client_unique_identifier":"ad1fb298900960c2d400c9f4860a1f31",
    "function":"create_personnel",
    "data":[
      {
        "first_name":"Text",
        "last_name":"Text",
        "title":"Text",
        "department":"Text",
        "location":"Text",
        "employee_status":396,
        "supervisor_first_name":"Text",
        "supervisor_last_name":"Text",
        "username":"Some Text",
        "type":436,
        "employment_classification":1596,
        "employee_number":"1234",
        "supervisor_employee_number":"1234",
        "hire_date":"12\/25\/2013",
        "work_email":"null@example.com",
        "personal_email":"null@example.com",
        "termination_date":"12\/25\/2013",
        "middle_name":"Text",
        "ssn":"123-45-6789",
        "dob":"12\/25\/2013",
        "address":"Text. More text.",
        "city":"Text",
        "home_state_province":"Text",
        "zip_code":"12345-6789",
        "country":"Text",
        "mobile_phone":"Some Text",
        "home_phone":"Text",
        "work_phone":"Text",
        "drivers_license_number":"Text",
        "drivers_license_state":"Text",
        "drivers_license_expiration_date":"12\/25\/2013"
      },
      {
        "first_name":"Text",
        "last_name":"Text",
        "title":"Text",
        "department":"Text",
        "location":"Text",
        "employee_status":396,
        "supervisor_first_name":"Text",
        "supervisor_last_name":"Text",
        "username":"Some Text",
        "type":436,
        "employment_classification":1596,
        "employee_number":"1234",
        "supervisor_employee_number":"1234",
        "hire_date":"12\/25\/2013",
        "work_email":"null@example.com",
        "personal_email":"null@example.com",
        "termination_date":"12\/25\/2013",
        "middle_name":"Text",
        "ssn":"123-45-6789",
        "dob":"12\/25\/2013",
        "address":"Text. More text.",
        "city":"Text",
        "home_state_province":"Text",
        "zip_code":"12345-6789",
        "country":"Text",
        "mobile_phone":"Some Text",
        "home_phone":"Text",
        "work_phone":"Text",
        "drivers_license_number":"Text",
        "drivers_license_state":"Text",
        "drivers_license_expiration_date":"12\/25\/2013"
      }
    ]
  }
}
```

Example Response:

```
{
  "payload":{
    "client_unique_identifier":"279a83bcb36851e50b39cf6cea71141e",
    "result":"success",
    "error_code":null,
    "error_desc":null,
    "warnings":[
      
    ],
    "data":[
      {
        "id":"500"
      }
    ]
  }
}
```

Copyright 2018 Compli All Rights Reserved
