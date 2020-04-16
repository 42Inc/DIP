#!/usr/bin/env python
import sys

if __name__ == "__main__":
    cursor_num = None
    cursor_count = 0
    for line in sys.stdin:
        data = line.split("\t")
        num = int(data[0])
        count = int(data[1])
        if cursor_num == num:
            cursor_count += count
        else:
            if cursor_num:
                print '%s\t%s' % (cursor_num, cursor_count)
            cursor_count = count
            cursor_num = num
    print '%s\t%s' % (cursor_num, cursor_count)
