#!/usr/bin/env python
import sys

current_word = None
current_count = 0
current_key = None

for line in sys.stdin:
    data = line.split('\t')
    key = data[0]
    word = data[1]
    count = int(data[2])

    if current_key == key:
        if current_word == word:
            current_count += count
        else:
            if current_word:
                print '%s\t%s\t%s' % (current_key, current_word, current_count)
            current_count = count
            current_word = word
    else:
        if current_word == word:
            current_count += count
        else:
            if current_word:
                print '%s\t%s\t%s' % (current_key, current_word, current_count)
            current_count = count
            current_word = word
        current_key = key
            

print '%s\t%s\t%s' % (current_key, current_word, current_count)
