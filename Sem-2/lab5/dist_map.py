#!/usr/bin/env python
import sys

if __name__ == "__main__":
    for line in sys.stdin:
	data = line.rstrip().split("\t")
	print '%s\t%s' % (data[1], 1)