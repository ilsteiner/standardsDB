import json

# Maybe send the data to JSON or a CSV? CSV is probably easier.

with open("elements.json") as theFile:
	theData = json.load(theFile)
	print(theData["elements"][0]["element1"])