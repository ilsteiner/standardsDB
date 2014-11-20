import json
import random

def custround(x, base=5):
    return int(base * round(float(x)/base))

# Varaible for the CSV version of the processed data
csvData = ""

# Variable for the valid thicknesses
validValues = [2,4,10,20,40]

with open("elements.json") as theFile:
	theData = json.load(theFile)
	for i in range (0,len(theData["elements"])):
		theData["elements"][i]["thicknesses"] = [2,4,10,20,40,80,120,160,200,240,280,320,360,400,440,480,520,560,600,640,680,720,760,800]
		price = random.randint(500,1000)
		for j in range(0,len(theData["elements"][i]["thicknesses"])):
			output = ",".join([theData["elements"][i]["element1"],theData["elements"][i]["element2"],theData["elements"][i]["plated"],str(theData["elements"][i]["thicknesses"][j]),str(random.randint(5,200))])
			if(theData["elements"][i]["element2"] == ""):
				output = ",".join([output,str(custround(price))])
			else:
				output = ",".join([output,str(custround(price*1.3))])

			print(output)

			price = price - (price * .1)