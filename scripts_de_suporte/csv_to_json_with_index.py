import csv
import json
a = []
id = 0
with open('ALL_STATES.csv', 'rU') as csvfile:
    reader = csv.reader(csvfile, delimiter=',')
    for row in reader:
        state, gender, year, name, ocurrence = row[0:5]
        a.append('{\"index\":{\"_index\":\"all_states\",\"_id\":%d}}\n' %id)
        a.append('{\"id\":'+str(id)+',\"state\":\"'+state+"\",\"gender\":\""+gender+"\",\"year\":"+year+",\"name\":\""+name+"\",\"occurrences\":"+ocurrence+"}\n")
        id = id + 1
a = ''.join(a) 
csvfile.close()
f = open("ALL_STATES.json", "w")
f.write(a)
f.close()
print("JSON salvo!")
