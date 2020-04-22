#!/usr/bin/env python
import sys

current_count = 0
current_key = None

for line in sys.stdin:
    data = line.split('\t')
    key = data[1]

    if current_key != key:
        current_key = key
        current_count += 1

print '%s' % (current_count)
