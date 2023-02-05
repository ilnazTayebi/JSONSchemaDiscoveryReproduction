#!/bin/sh

if [ $# -eq 0 ]
  then
    echo "No collectionName supplied"
fi

# while getopts "c:" arg; 
#   do
#     case $arg in
#       c) collectionName=$OPTARG;;
#     esac
# done


if [ $1 = "doall" ]
then
    mongorestore  --db  jsonschemadiscovery --collection venues /dataset/venues.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
    mongorestore  --db  jsonschemadiscovery --collection checkins /mongo-seed/checkins.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
    mongorestore  --db  jsonschemadiscovery --collection tweets /mongo-seed/tweets.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
fi

if [ $1 = "venues" ]
then
    mongorestore  --db  jsonschemadiscovery --collection venues /dataset/venues.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
fi

if [ $1 = "checkins" ]
then
    mongorestore  --db  jsonschemadiscovery --collection checkins /mongo-seed/checkins.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
fi

if [ $1 = "tweets" ]
then
    mongorestore  --db  jsonschemadiscovery --collection tweets /mongo-seed/tweets.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
fi