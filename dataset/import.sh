#!/bin/sh

mongorestore  --db  jsonschemadiscovery --collection venues /dataset/venues.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
# mongorestore  --db  jsonschemadiscovery --collection checkins /mongo-seed/checkins.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"
# mongorestore  --db  jsonschemadiscovery --collection tweets /mongo-seed/tweets.bson --uri "mongodb://mongo:27017/jsonschemadiscovery"