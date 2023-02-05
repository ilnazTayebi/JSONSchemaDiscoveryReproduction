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
rm /usr/bin/resultsvenues/*.txt
rm /usr/bin/resultsvenues/*.json
echo "Host: $host; Port: $port"
# Create an account
curl $host:$port/api/register -X POST -H 'Content-Type: application/json' -d '{"username": "test", "email": "test@test.de", "password": "test123456"}' > /usr/bin/resultsvenues/info.txt
# Login and get back the Token
curl $host:$port/api/login -X POST -H 'Content-Type: application/json' -d '{"email": "test@test.de", "password": "test123456"}' > /usr/bin/resultsvenues/token.txt
token=$(jq .token -r /usr/bin/resultsvenues/token.txt)
header1="Content-Type: application/json"
header2="Authorization: Bearer"
curl $host:$port/api/batches -H "$header1" -H "$header2 $token" > /usr/bin/resultsvenues/batches.txt


curl $host:$port/api/batch/rawschema/steps/all -X POST -H 'Content-Type: application/json' -H "$header2 $token" -d '{"authentication":{"authMechanism":"SCRAM-SHA-1"},"port":"27017","address":"mongo","databaseName":"jsonschemadiscovery","collectionName":"venues","rawSchemaFormat":false}' > /usr/bin/resultsvenues/allsteps.txt

curl $host:$port/api/batches -H 'Content-Type: application/json' -H "$header2 $token" > /usr/bin/resultsvenues/allbatches.txt

jq '.[] | select( .status == "DONE" ) |  select( .collectionName == "venues") | ._id' -r /usr/bin/resultsvenues/allbatches.txt > /usr/bin/resultsvenues/batchidlist.txt

# REDUCE_DOCUMENTS
while read -u 10 id; do
	curl $host:$port/api/batch/$id -H 'Content-Type: application/json' -H "$header2 $token" > /usr/bin/resultsvenues/batch_$id.json
done 10< /usr/bin/resultsvenues/batchidlist.txt
