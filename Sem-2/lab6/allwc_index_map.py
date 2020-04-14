#!/usr/bin/env python
import sys

for line in sys.stdin:
	words = line.rstrip().lower().split()
	key = words[0].rstrip()
	for word in range(1, len(words)):
		print '%s\t%s' % (words[word].rstrip(), 1)

