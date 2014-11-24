import json
import random

elemFile = open("elements.json")
partFile = open("parts.json")

elems = json.load(elemFile)
parts = json.load(partFile)
standards = []
numCerts = 1
numStandards = 0
currCert = 1111111111
certifications = [currCert]

class Standard(object):
	partNumber = ""
	certNumber = ""
	actualValue = 0

	def __init__(self,partNumber,certNumber,actualValue):
		self.partNumber = partNumber
		self.certNumber = certNumber
		self.actualValue = actualValue

	def __repr__(self):
		return self.partNumber + "," + self.certNumber + "," + str(self.actualValue)

def make_standard(partNumber,certNumber,actualValue):
	newStandard = Standard(partNumber,certNumber,actualValue)
	return newStandard

def percentDiff(value,percent):
	return value + (value * (percent / 100))

def withinPercent(actualValue,targetValue,errorMargin):
	lowEnd = targetValue - (targetValue * errorMargin)
	highEnd = targetValue + (targetValue * errorMargin)
	return ((actualValue >= lowEnd) and (actualValue <= highEnd))

for p in range (0,len(parts["parts"])):
	for i in range (0,parts["parts"][p]["Stock"]):
		# Set the actualValue to a random number from a normal distribuition whose standard deviation is 5% 
		# Roughly 68% of standards will be within the error tolerance
		actualValue = round(random.normalvariate(parts["parts"][p]["Thickness"],.1),2)
		if(withinPercent(actualValue,parts["parts"][p]["Thickness"],.1)):
			standards.append(make_standard(parts["parts"][p]["partNumber"],'C'+str(currCert),actualValue))
			# We'll probably increment the cert number, but we might not
			if(random.random() < .93):
				currCert += 1
				numCerts += 1
				certifications.append(currCert)
		else:
			standards.append(make_standard(parts["parts"][p]["partNumber"],'null',actualValue))

		numStandards += 1
print('We created ' + str(numStandards) + ' standards.')
print('We created ' + str(numCerts) + ' corresponding certifications.')
print('*' * 100)
for num in certifications:
	print(num)
print('*' * 100)
for s in standards:
	print(s)