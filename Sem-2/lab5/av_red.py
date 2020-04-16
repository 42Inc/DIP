#!/usr/bin/env python
import sys

if __name__ == "__main__":
    users_count = 0
    followers_count = 0.0
    average = 0.0
    for line in sys.stdin:
        data = line.split("\t")
        value = data[1]
        users_count += 1
        followers_count = followers_count + int(value)
    if users_count != 0:
        average = followers_count / users_count
    print '%s\t%s' % (users_count, average)
