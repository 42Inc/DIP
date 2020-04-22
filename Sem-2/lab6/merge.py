#!/usr/bin/env python3

import sys
import numpy

WC = []
ALLWC = []
doc_count = 0
current_id = None
for line in sys.stdin:
    data = line.rstrip().split("\t")
    if len(data) == 3:
        # WC.append([data[0], data[1], data[2]])
        id = data[0]
        word = data[1]
        count = float(data[2])
        allwc_count = None
        for allwc_elem in ALLWC:
            if word == allwc_elem[0]:
                allwc_count = int(allwc_elem[1])
                break
        if allwc_count != None:
            idf = float(numpy.log10(doc_count / allwc_count))
            print(id, "\t", word, "\t", count * idf)

    elif len(data) == 2:
        ALLWC.append([data[0], data[1]])
        # print("Read allwc: ", line)
    elif len(data) == 1:
        doc_count = int(data[0])
        print("Docs count: ", doc_count)


# for elem in WC:
#     id = elem[0]
#     word = elem[1]
#     count = float(elem[2])
#     allwc_count = None
#     for allwc_elem in ALLWC:
#         if word == allwc_elem[0]:
#             allwc_count = int(allwc_elem[1])
#             break
#     if allwc_count != None:
#         idf = float(numpy.log10(doc_count/allwc_count))
#         print(id, "\t", word, "\t", count*idf)
