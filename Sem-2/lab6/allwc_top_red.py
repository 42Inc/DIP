#!/usr/bin/env python
import sys
import re

if __name__ == "__main__":
    Top = []
    N = 20
    for line in sys.stdin:
        Top.append(line.rstrip().split("\t"))
    Top.sort(key=lambda x: int(x[2]), reverse=True)
    if len(Top) < N:
        N = len(Top)
    for i in range(N):
        # datas = str(Top[i][1])
        datas = re.sub(r'\|', "\\\\\\\\|", Top[i][1])
        datas = re.sub(r"\*", "\\\\\\\\*", datas)
        datas = re.sub(r"\+", "\\\\\\\\+", datas)
        datas = re.sub(r"\.", "\\\\\\\\.", datas)
        datas = re.sub(r"\(", "\\\\\\\\(", datas)
        datas = re.sub(r"\)", "\\\\\\\\)", datas)
        if i == (N - 1):
            sys.stdout.write(datas.rstrip("\n\r\t"))
        else:
            sys.stdout.write(datas.rstrip("\n\r\t"))
            sys.stdout.write("|")
