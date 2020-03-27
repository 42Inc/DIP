#!/usr/bin/env python
import sys

if __name__ == "__main__":
    cursor_id = None
    cursor_count = 0
    for line in sys.stdin:
	data = line.split("\t")
	id = int(data[0])
	count = int(data[1])
	if cursor_id == id:
	    cursor_count += count
	else:
	    if cursor_id:
		print '%s\t%s' % (cursor_id, cursor_count)
	    cursor_count = count
	    cursor_id = id
    print '%s\t%s' % (cursor_id, cursor_count)