import time
import os
import mysql.connector

con = mysql.connector.connect(	user='root', 
								password='root' if os.environ.get("MYSQL_PASSWORD") == None else os.environ.get("MYSQL_PASSWORD"),
								host='127.0.0.1' if os.environ.get("MYSQL_HOST") == None else os.environ.get("MYSQL_HOST"),
								database='trabalho')
print("Conexão aberta com sucesso!")

cursor = con.cursor()

query = input("Qual busca Gostaria de realizar?\nQuery: ")
visualizar = input("Gostaria de visualizar o resultado? (y/N): ")
t = time.time()
cursor.execute(query)
elapsed = time.time() - t

i = 0
if(visualizar == 'y'):
	for row in cursor:
		i = 1 + i
		print (row)
else:
	for row in cursor:
		i = 1 + i

print("Demorou " + str(elapsed) +" Segundos para realizar a busca, num total de " + str(i)+ " linhas.")


cursor.close()
con.close()
print("Conexão encerrada!")