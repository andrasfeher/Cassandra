import logging
from cassandra import ConsistencyLevel
from cassandra.cluster import Cluster, BatchStatement
from cassandra.query import SimpleStatement
from datetime import datetime

if __name__ == '__main__':
    cluster = Cluster(['localhost'])
    session = cluster.connect('mykeyspace')

    while True:

        rows = session.execute('select count(*) as cnt from tbl')

        for row in rows:
            print('count:', row.cnt)

    cluster.shutdow
