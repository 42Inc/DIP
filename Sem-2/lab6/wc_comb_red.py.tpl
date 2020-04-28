#!/usr/bin/env python3
# coding=utf8
import sys
import numpy
import re

N = 10

docs_count = DOCUMENTS_COUNT
matcher_regex = r"^(MATCHER_REGEX)$"
current_word = None
current_count = 0
current_key = None

tmp_docs = []
tmp_docs_count = 0
docs_key = None
docs = []
match = None

for line in sys.stdin:
    data = line.split('\t')
    if len(data) < 3:
        continue
    key = data[1]
    word = data[0]
    count = int(data[2])

    if current_word == None:
        current_word = word

    # print 'Read %s' % (line)
    if current_word == word:
        current_count += count
        tmp_docs.append([key, count])
        current_key = key
    else:
        tmp_docs.sort(key=lambda x: int(x[0]), reverse=True)
        # print 'Word %s' % (current_word)
        # print (tmp_docs)
        for i in tmp_docs:
            if docs_key == None:
                docs_key = i[0]
            if docs_key == i[0]:
                tmp_docs_count += i[1]
            else:
                docs.append([docs_key, tmp_docs_count, -1])
                docs_key = i[0]
                tmp_docs_count = i[1]
        if len(tmp_docs) > 0:
            docs.append([docs_key, tmp_docs_count, -1])
        idf = float(numpy.log10(float(docs_count) / float(current_count)))
        for i in range(len(docs)):
            docs[i][2] = docs[i][1] * idf
        docs.sort(key=lambda x: x[2], reverse=True) 
        N = 10
        if N > len(docs):
            N = len(docs)
        # print(N)
        # print(docs)
        # print(len(docs))
        match = None
        match = re.match(matcher_regex, current_word, 0);
        if match == None:
            sys.stdout.write(str(current_word))
            sys.stdout.write("\t")
            for i in range(N):
                # print(docs[i][0], docs[i][2], sep=',', end='\t')
                sys.stdout.write(str(docs[i][0]))
                sys.stdout.write(",")
                sys.stdout.write(str(docs[i][2]))
                sys.stdout.write("\t")  
                # print '%s\t%s\t%s' % (current_word, docs[i][0], docs[i][2]).
            # print
            sys.stdout.write("\n")
        current_word = word
        tmp_docs = []
        docs = []
        docs_key = None
        tmp_docs_count = 0
        current_count = count
        tmp_docs.append([key, count])
        current_key = key

tmp_docs.sort(key=lambda x: int(x[0]), reverse=True)

for i in tmp_docs:
    if docs_key == None:
        docs_key = i[0]
    if docs_key == i[0]:
        tmp_docs_count += i[1]
    else:
        docs.append([docs_key, tmp_docs_count, -1])
        docs_key = i[0]
        tmp_docs_count = i[1]
if len(tmp_docs) > 0:
    docs.append([docs_key, tmp_docs_count, -1])
idf = float(numpy.log10(float(docs_count) / float(current_count)))
for i in range(len(docs)):
    docs[i][2] = docs[i][1] * idf
docs.sort(key=lambda x: x[2], reverse=True)
N = 10
if N > len(docs):
    N = len(docs)
# print(current_word, end='\t')
match = None
match = re.match(matcher_regex, current_word, 0);
if match == None:
    sys.stdout.write(str(current_word))
    sys.stdout.write("\t")
    for i in range(N):
        # Word DocId TF-IDF
        # print(docs[i][0], docs[i][2], sep=',', end='\t')
        sys.stdout.write(str(docs[i][0]))
        sys.stdout.write(",")
        sys.stdout.write(str(docs[i][2]))
        sys.stdout.write("\t")  
        # print '%s\t%s\t%s' % (current_word, docs[i][0], docs[i][2])
    sys.stdout.write("\n")