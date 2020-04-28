#!/usr/bin/env python
import sys

if __name__ == "__main__":
    Top = []
    N = 4
    for line in sys.stdin:
        Top.append(line.rstrip().split("\t"))
    Top.sort(key=lambda x: int(x[2]), reverse=True)
    if len(Top) < N:
        N = len(Top)
    for i in range(N):
        if i == N - 1:
            sys.stdout.write(str(Top[i][1]).rstrip("\n\r\t"))
        else:
            sys.stdout.write(str(Top[i][1]).rstrip("\n\r\t"))
            sys.stdout.write("|")
