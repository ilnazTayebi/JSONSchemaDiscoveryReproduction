#!/bin/sh


host=localhost
port=3000

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
fi

while getopts "h: p:" arg; 
  do
    case $arg in
      h) host=$OPTARG;;
      p) port=$OPTARG;;
    esac
done
rm /usr/bin/reproresults/*.txt
rm /usr/bin/reproresults/*.json
echo "Host: $host; Port: $port"
# Create an account
curl $host:$port/api/register -X POST -H 'Content-Type: application/json' -d '{"username": "tayebi", "email": "tayebi@tayebi.de", "password": "tayebi107323"}' > /usr/bin/reproresults/info.txt
# Login and get back the Token
curl $host:$port/api/login -X POST -H 'Content-Type: application/json' -d '{"email": "tayebi@tayebi.de", "password": "tayebi107323"}' > /usr/bin/reproresults/token.txt
token=$(jq .token -r /usr/bin/reproresults/token.txt)
header1="Content-Type: application/json"
header2="Authorization: Bearer"
curl $host:$port/api/batches -H "$header1" -H "$header2 $token" > /usr/bin/reproresults/batches.txt


curl $host:$port/api/batch/rawschema/steps/all -X POST -H 'Content-Type: application/json' -H "$header2 $token" -d '{"authentication":{"authMechanism":"SCRAM-SHA-1"},"port":"27017","address":"mongo","databaseName":"jsonschemadiscovery","collectionName":"checkins","rawSchemaFormat":false}' > /usr/bin/reproresults/allsteps.txt

curl $host:$port/api/batches -H 'Content-Type: application/json' -H "$header2 $token" > /usr/bin/reproresults/allbatches.txt

jq '.[] | select( .status == "DONE" ) |  select( .collectionName == "checkins") | ._id' -r /usr/bin/reproresults/allbatches.txt > /usr/bin/reproresults/batchidlist.txt

# REDUCE_DOCUMENTS
while read -u 10 id; do
	curl $host:$port/api/batch/$id -H 'Content-Type: application/json' -H "$header2 $token" > /usr/bin/reproresults/batch_$id.json
done 10< /usr/bin/reproresults/batchidlist.txt

# REDUCE_DOCUMENTS