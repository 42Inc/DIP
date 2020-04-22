#!/usr/bin/env python
import sys
prev_key = None
for line in sys.stdin:
    words = line.rstrip().lower().split()
    key = words[0].rstrip()
    if prev_key != key:
        print '%s\t%s' % (key, 42)
        prev_key = key
