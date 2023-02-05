#!/bin/sh
collectionName= doall
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
fi

while getopts "c:" arg; 
  do
    case $arg in
      c) collectionName=$OPTARG;;
    esac
done


if [ $collectionName="doall"]
then
    mongorestore  --db  jsonschemadiscovery --collection venues /dataset/venues.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
    mongorestore  --db  jsonschemadiscovery --collection checkins /mongo-seed/checkins.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
    mongorestore  --db  jsonschemadiscovery --collection tweets /mongo-seed/tweets.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
fi

if [ $collectionName="venues"]
then
    mongorestore  --db  jsonschemadiscovery --collection venues /dataset/venues.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
fi

if [ $collectionName="checkins"]
then
    mongorestore  --db  jsonschemadiscovery --collection checkins /mongo-seed/checkins.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
fi

if [ $collectionName="tweets"]
then
    mongorestore  --db  jsonschemadiscovery --collection tweets /mongo-seed/tweets.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
fi