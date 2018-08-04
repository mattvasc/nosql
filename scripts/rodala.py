

N=150000
contadorarq = 0

contadorlinha = 0



filex = open("json"+str(contadorarq)+".json", "w")

with open('ALL_STATES.json') as openfileobject:
	for line in openfileobject:
		
		
		if(contadorlinha==150000):
			filex.close()
			contadorarq = contadorarq + 1
			filex = open("json"+str(contadorarq)+".json", "w")
			contadorlinha = 0
			filex.write(line)
		else:
			filex.write(line)
			contadorlinha = contadorlinha + 1

filex.close()
			
		
			
		