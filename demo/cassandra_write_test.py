import logging
from cassandra import ConsistencyLevel
from cassandra.cluster import Cluster, BatchStatement
from cassandra.query import SimpleStatement
from datetime import datetime

'''
drop keyspace mykeyspace;

CREATE KEYSPACE mykeyspace
WITH replication = {
 	'class' : 'NetworkTopologyStrategy',
	'Budapest' : 2,
	'New York' : 1
};

CREATE TABLE mykeyspace.tbl (id int primary key)
'''

if __name__ == '__main__':
    cluster = Cluster(['localhost'])
    session = cluster.connect('mykeyspace')

    cql_stmt = session.prepare("INSERT INTO tbl (id) VALUES (?)")
    cql_stmt.consistency_level = ConsistencyLevel.QUORUM

    for i in range(1, 20000):
        session.execute(cql_stmt, [i])
        print('id:', i)

    cluster.shutdown()
