#!/usr/bin/env python
import sys

for line in sys.stdin:
    words = line.lower().split()
    for word in words:
        print '%s\t%s' % (word, 1)