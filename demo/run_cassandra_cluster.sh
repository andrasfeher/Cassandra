#!/bin/bash


# drop keyspace mykeyspace;


# CREATE KEYSPACE mykeyspace
# WITH replication = {
# 	'class' : 'NetworkTopologyStrategy',
# 	'Budapest' : 2,
# 	'New York' : 1
# };


# CREATE TABLE mykeyspace.tbl (id int primary key);

# select count(*) from mykeyspace.tbl;

# select max(id) from mykeyspace.tbl;

# truncate mykeyspace.tbl;


docker run --name cas1 -p 9042:9042 -e CASSANDRA_CLUSTER_NAME=MyCluster -e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch -e CASSANDRA_DC=Budapest -e _JAVA_OPTIONS="-Xms1024M -Xmx1024M" -d cassandra && \
sleep 60 && \
docker run --name cas2 -e CASSANDRA_SEEDS="$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' cas1)" -e CASSANDRA_CLUSTER_NAME=MyCluster -e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch -e CASSANDRA_DC=Budapest -e _JAVA_OPTIONS="-Xms1024M -Xmx1024M" -d cassandra && \
sleep 60 && \
docker run --name cas3 -e CASSANDRA_SEEDS="$(docker inspect --format='{{ .NetworkSettings.IPAddress }}' cas1)" -e CASSANDRA_CLUSTER_NAME=MyCluster -e CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch -e CASSANDRA_DC="New York" -e _JAVA_OPTIONS="-Xms1024M -Xmx1024M" -d cassandra

