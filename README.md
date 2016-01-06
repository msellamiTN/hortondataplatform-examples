# Hortonworks Data Platform

## Automated Install with Ambari 

* Launch the container running Ambari Server and Ambari Agent
```
docker run  -p 8080:8080 --rm -ti --privileged --name hdp -h hdp torusware/hortondataplatform-examples
```
* Open your browser and go to http://localhost:8080
* Access a running container through ssh
```
$ sshpass -p 'torus' ssh root@<container IP>
```

## Spark examples

### Configure environment

- Set up the Hadoop ecosystem
  1. Pull container `docker pull torusware/hortondataplatform-examples`
  2. Launch container as above: `docker run  -p 8080:8080 --rm -ti --privileged --name hdp -h hdp torusware/hortondataplatform-examples`
  3. Get a shell within the running container, run ntp service and copy ssh key
  ```
  docker exec -ti hdp /bin/bash
  $ service ntp start
  $ cat .ssh/id_rsa
  ```
- Access http://localhost:8080 from your host browser
  1. Login: admin/admin
  2. Launch install wizard with the hostname and ssh key set in the configuration step
  3. Install services: HDFS, YARN, Ambari Metrics and Spark

- Run examples within the container shell

### Run examples

- [TwitterPopularTags](https://github.com/apache/spark/blob/master/examples/src/main/scala/org/apache/spark/examples/streaming/TwitterPopularTags.scala)

  ```
  spark-submit --class org.apache.spark.examples.streaming.TwitterPopularTags \           
  /usr/hdp/current/spark-client/lib/spark-examples-1.5.2.2.3.4.0-3485-hadoop2.7.1.2.3.4.0-3485.jar \
  <consumer key> <consumer secret> <access token> <access token secret>  [<filters>]
  ```
