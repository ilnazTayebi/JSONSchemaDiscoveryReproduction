# Reproduction Package for "JSONSchemaDiscovery"
This project provides the reproduction package for 
the JSONSchemaDiscovery.It is intended to discover the
Schema behind the existing JSON data file.

## Building the Docker image
- Clone the repository
  > git clone https://github.com/ilnazTayebi/JSONSchemaDiscoveryReproduction.git
- Build the Docker image from scratch
  > cd JSONSchemaDiscoveryReproduction

  > docker-compose up

 - Now, we can get an interactive shell of the running docker service:

  > $ docker exec -it api  bash
  
  -The measurement is based on the FOURSQUARE dataset, which is produced by ÇELIKTEN, E.; FALHER, G. L.; MATHIOUDAKIS, M. Modeling urban behavior mining geotagged social data. IEEE Transactions on Big Data, v. 3, n. 2, p. 220–233,June 2017. Use the following step to evaluate the average processing time spent in the schema extraction process for FOURSQUARE the datasets :
      
      -For generate the result based on  all tree Jason data files:
      
      > $ doallsteps.sh

       -For generate the result based on the Venuess:

      > $ dovenuesschema.sh

      -For generate the result based on the checkins:

      > $ docheckinsschema.sh

      -For generate the result based on the tweets:

      > $ dotweetsschema.sh
      
      -Runnig doallsteps.sh takes much time to run.

  -Finally, we need to visualise the results and generate the paper.While the paper is written in LaTeX, we use python to
  produce  the average processing time spent in the schema extraction process from the data, and integrate them into the LaTeX sources.

  > $ prepare_data.sh
   