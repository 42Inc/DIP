#!/usr/bin/env python
import sys

if __name__ == "__main__":
    Top = []
    N = 20
    local_n = N
    current_key = None

    for line in sys.stdin:
        data = line.rstrip().split("\t")
        key = data[1]
        word = data[2]
        count = data[3]
        if current_key == None:
            Top = []
            current_key = key
        elif current_key != key:
            local_n = N
            Top.sort(key=lambda x: int(x[1]), reverse=True)
            if len(Top) < N:
                local_n = len(Top)
            for i in range(local_n):
                print '%s\t%s\t%s' % (current_key, Top[i][0], Top[i][1])
            current_key = key
            Top = []
        Top.append([word, count])

    if len(Top) > 0:
        local_n = N
        Top.sort(key=lambda x: int(x[1]), reverse=True)
        if len(Top) < N:
            local_n = len(Top)
        for i in range(local_n):
            print '%s\t%s\t%s' % (current_key, Top[i][0], Top[i][1])