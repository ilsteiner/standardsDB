import json
import random

compsFile = open("standardComponents.json")

comps = json.load(compsFile)
newComps = []
currPart = ""
cSum = 0
newComp = 0

def randDiff(mean):
	diff = mean - random.normalvariate(mean,5)
	if(random.randint(0,1) == 1):
		return diff
	else:
		return -diff

# TODO: Generate compositions within some range from the desired composition
# Make sure to handle 100% compositions. Build the insert statements based on this.

for s in range (0,len(comps["comps"])):
	# Pure standard
	if(comps["comps"][s]["composition"] == 100):
		newComps.append([comps["comps"][s]["serialNumber"],comps["comps"][s]["partNumber"],comps["comps"][s]["symbol"],100])
	elif(newComp == 0):
		# Generate a composition close to the target value
		newComp = round((comps["comps"][s]["composition"] + (randDiff(int(comps["comps"][s]["composition"])))),2)
		newComps.append([comps["comps"][s]["serialNumber"],comps["comps"][s]["partNumber"],comps["comps"][s]["symbol"],newComp])
	else:
		# The rest of the standard is whatever the other element is
		newComps.append([comps["comps"][s]["serialNumber"],comps["comps"][s]["partNumber"],comps["comps"][s]["symbol"],round(100 - newComp,2)])
		newComp = 0
for c in newComps:
	print(c)