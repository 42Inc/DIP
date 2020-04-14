#!/usr/bin/env python
import sys

if __name__ == "__main__":
    Top = []
    N = 20
    for line in sys.stdin:
        Top.append(line.rstrip().split("\t"))
    Top.sort(key=lambda x: int(x[2]), reverse=True)
    if len(Top) < N:
        N = len(Top)
    for i in range(N):
        print '%s\t%s' % (Top[i][1], Top[i][2])
