import glob
import os
import datetime
import json

def generatetable():
	directory = "."
	os.chdir(directory)
	file_list = glob.glob("/usr/bin/reproresults/*.json")
	# print("Files: ", file_list)
	print ("\begin{tabular}{l|rrrrrrr}")
	print("\toprule")
	# header = "{} & {} & {} & {}".format("Collection", "RS", "ROrd", "TB")
	headers = ["Collection","RS","RS","ROrd","TB"]
	print(headers)
	print("\midrule")
	for filename in file_list:
		with open(filename) as f:
			data = json.load(f)
			start = datetime.datetime.strptime(data['startDate'], '%Y-%m-%dT%H:%M:%S.%fZ')
			end = datetime.datetime.strptime(data['endDate'], '%Y-%m-%dT%H:%M:%S.%fZ')
			time_difference = end - start
			row = "{} & {} & {} & {}".format(data['collectionName'], data['collectionCount'], data['uniqueUnorderedCount'], data['uniqueOrderedCount'], time_difference)
			print(row)
	print("\bottomrule")
	print("\end{tabular}")

if __name__ == '__main__':
	generatetable()