#!/usr/bin/env python
import sys

if __name__ == "__main__":
    for line in sys.stdin:
	data = line.rstrip().split(" ")
	print '%s\t%s' % (data[0], 1)