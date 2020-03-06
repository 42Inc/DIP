#!/usr/bin/env python
import sys

current_word = None
current_count = 0

for line in sys.stdin:
    data = line.split('\t')
    word = data[0]
    count = int(data[1])

    if current_word == word:
        current_count += count
    else:
        if current_word:
            print '%s\t%s' % (current_word, current_count)
        current_count = count
        current_word = word

print '%s\t%s' % (current_word, current_count)
