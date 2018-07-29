import csv
import json

f = open("../ALL_STATES.csv", "rU")

reader = csv.DictReader(f, fieldnames=("state", "gender","year","name","occurrences") )
print ("CSV loaded! Creating JSON...")
out = json.dumps( [ row for row in reader] )
print("JSON created, dumping to file...")
f.close()
f = open("../ALL_STATES.json", "w")
f.write(out)
f.close()
print("JSON saved!")

