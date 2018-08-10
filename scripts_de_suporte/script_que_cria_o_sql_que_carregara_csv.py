import os
states = os.listdir()
num_lines = 0
for state in states:
   if ".TXT" in state:
      print ("LOAD DATA LOCAL INFILE '/home/ada/Documents/dataset/" + state + "' INTO TABLE names FIELDS TERMINATED BY ',' LINES TERMINATED BY '\\n'; ")
      #print("Going to count lines in " +state)
      num_lines = num_lines + sum(1 for line in open(state))
print("Total of lines: " + str(num_lines))
  
