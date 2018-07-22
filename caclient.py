import time
import os
from cassandra.cluster import Cluster

if "CASSANDRA_CLUSTER_IP" in os.environ:
    cluster = Cluster([os.environ['CASSANDRA_CLUSTER_IP']])
else:
    cluster = Cluster()

session = cluster.connect("trabalho")
print("Conexão ao keyspace trabalho realizada com sucesso!")



query = input("Qual busca Gostaria de realizar?\nQuery: ")
visualizar = input("Gostaria de visualizar o resultado? (y/N): ")
t = time.time()
rows = session.execute(query)
elapsed = time.time() - t

i = 0
if(visualizar == 'y'):
	for row in rows:
		i = 1 + i
		print (row)
else:
	for row in rows:
		i = 1 + i
    	

print("Demorou " + str(elapsed) +" Segundos para realizar a busca, num total de " + str(i)+ " linhas.")

