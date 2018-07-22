import time
from cassandra.cluster import Cluster

cluster = Cluster()

session = cluster.connect("trabalho")

t = time.time()
rows = session.execute("SELECT * FROM names WHERE name = 'Anna' GROUP BY state allow filtering;")
elapsed = time.time() - t

#for row in rows:
#	print (row)

print(elapsed)
