import json

elemFile = open("elements.json")
partFile = open("parts.json")

elems = json.load(elemFile)
parts = json.load(partFile)
components = []

class Component(object):
	symbol = ""
	partNumber = ""
	composition = 0

	def __init__(self,symbol,partNumber,composition):
		self.symbol = symbol
		self.partNumber = partNumber
		self.composition = composition

	def __repr__(self):
		return self.symbol + "," + str(self.partNumber) + "," + str(self.composition) + '\n'

def make_component(symbol,partNumber,composition):
	newComponent = Component(symbol,partNumber,composition)
	return newComponent

for e in range (0,len(elems["elements"])):
	for p in range (0,len(parts["parts"])):
		if((parts["parts"][p]["Element1"] == elems["elements"][e]["Element1"]) and (parts["parts"][p]["Element2"] == elems["elements"][e]["Element2"]) and (elems["elements"][e]["Thickness"] == 40)):
			if(parts["parts"][p]["Element2"] == ""):
				components.append(make_component(parts["parts"][p]["Element1"],parts["parts"][p]["partNumber"],100))
			else:
				components.append(make_component(parts["parts"][p]["Element1"],parts["parts"][p]["partNumber"],70))
				components.append(make_component(parts["parts"][p]["Element2"],parts["parts"][p]["partNumber"],30))

print components			


