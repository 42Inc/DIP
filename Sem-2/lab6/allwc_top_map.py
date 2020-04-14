#!/usr/bin/env python
import sys

if __name__ == "__main__":
    Top = []
    N = 20
    for line in sys.stdin:
        Top.append(line.rstrip().split("\t"))
    Top.sort(key=lambda x: int(x[1]), reverse=True)
    if len(Top) < N:
        N = len(Top)
    for i in range(N):
        print '%s\t%s\t%s' % (42, Top[i][0], Top[i][1])
