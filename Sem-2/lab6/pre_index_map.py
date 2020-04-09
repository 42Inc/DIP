#!/usr/bin/env python
import sys
import re

if __name__ == "__main__":
	key = ""
	for line in sys.stdin:
		line = line.rstrip()
		data = line.split("\t")
		local_key = re.match(r'\d*<uniqid>', data[0], 0)
		line = re.sub(r'<uniqid>', "", line)
		if local_key:
			if re.sub(r'<uniqid>', "", local_key.group(0)) != key:
				key = re.sub(r'<uniqid>', "", local_key.group(0))
			print '%s' % (line)
		else:
			print '%s\t%s' % (key, line)
