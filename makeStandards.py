import json
import random

elemFile = open("elements.json")
partFile = open("parts.json")

elems = json.load(elemFile)
parts = json.load(partFile)
standards = []

class Standard(object):
	partNumber = ""
	certNumber = ""
	actualValue = 0

	def __init__(self,partNumber,certNumber,actualValue):
		self.partNumber = partNumber
		self.certNumber = certNumber
		self.actualValue = actualValue

	def __repr__(self):
		return self.partNumber + "," + self.certNumber + "," + str(self.actualValue) + '\n'

def make_standard(partNumber,certNumber,actualValue):
	newStandard = Standard(partNumber,certNumber,actualValue)
	return newStandard

def percentDiff(value,percent):
	return value + (value * (percent / 100))

for p in range (0,len(parts["parts"])):
	for i in range (0,parts["parts"][p]["Stock"]):
		# actualValue = round(random.uniform(percentDiff(parts["parts"][p]["Thickness"],-6),percentDiff(parts["parts"][p]["Thickness"],6)),2)
		actualValue = round(random.normalvariate(parts["parts"][p]["Thickness"],.05),2)
		standards.append(make_standard(parts["parts"][p]["partNumber"],"",actualValue))

print(standards)