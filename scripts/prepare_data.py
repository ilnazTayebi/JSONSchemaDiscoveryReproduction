import glob
import os
import datetime
import json

def main():
	directory = "."
	os.chdir(directory)
	file_list = glob.glob("*.json")
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
###################################################
#   \begin{tabular}{l|rrrrrrr}
#     \toprule    
#     Collection & N-JSON & RS &TB & TT &T B/TT\\
#     \midrule   
#     \$venues & \\
#      \$checkins & \\
#      \$tweets & \\
#   \bottomrule
# \end{tabular}

	# headers = ["Collection","RS","RS","ROrd","TB"]
	# data = dict()
	# # data["x 4"] = [1,2,3,1,0,9]
	# # data["x 5"] = [3,2,2,0,1,15]
	# # data["z"] = [1,9,3,0,0,0]
	# print(header)
	# print("\midrule")

	# textabular = f"l|{'r'*len(headers)}"
	# texheader = " & " + " & ".join(headers) + "\\\\"
	# texdata = "\\hline\n"
	# for label in sorted(data):
	# 	if label == "z":
	# 		texdata += "\\hline\n"
	# 	texdata += f"{label} & {' & '.join(map(str,data[label]))} \\\\\n"

	# print("\\begin{tabular}{"+textabular+"}")
	# print(texheader)
	# print(texdata,end="")
	# print("\\end{tabular}")

if __name__ == '__main__':
	main()