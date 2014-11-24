import json

compsFile = open("standardComponents.json")

comps = json.load(compsFile)
newComps = []
currPart = ""
cSum = 0

# TODO: Generate compositions within some range from the desired composition
# Make sure to handle 100% compositions. Build the insert statements based on this.
for s in range (0,len(comps["comps"]))
	if(comps["comps"][s]["Part Number"] == currPart)
		newComps.append([comps["comps"][s]["Serial Number"],comps["comps"][s]["Part Number"],comps["comps"][s]["Symbol"]])
		cSum += comps["comps"][s]["Composition"]