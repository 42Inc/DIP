#!/usr/bin/env python
import sys

if __name__ == "__main__":
    Top = []
    N = 20
    local_n = N
    current_key = None
    current_word = None

    for line in sys.stdin:
        data = line.rstrip().split("\t")
        word = data[0]
        count = data[1]
        key = data[2]
        if current_word == None:
            Top = []
            current_word = word
        elif current_word != word:
            local_n = N
            Top.sort(key=lambda x: int(x[1]), reverse=True)
            if len(Top) < N:
                local_n = len(Top)
            for i in range(local_n):
                print '%s\t%s\t%s' % (Top[i][0], key, Top[i][1])
            current_word = word
            Top = []
        Top.append([word, count])

    if len(Top) > 0:
        local_n = N
        Top.sort(key=lambda x: int(x[1]), reverse=True)
        if len(Top) < N:
            local_n = len(Top)
        for i in range(local_n):
            print '%s\t%s\t%s' % (Top[i][0], key, Top[i][1])