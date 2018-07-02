#! /usr/bin/python3

import json
from subprocess import call

if __name__ == "__main__":
	info = json.load(open('rewire/info.json', 'r'))
	output_name = "rewire_" + info['version'] + '.zip'

	print(output_name)
	
	# execute zip
	call(['zip -r ' + output_name + ' rewire/'], shell=True)
	
