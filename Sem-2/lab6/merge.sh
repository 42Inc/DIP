#!/bin/bash
if [ ! $# -eq 1 ]; then
  printf "Usage: $(echo $0) <script name>\n"
  exit 1
fi

test -f $1
[ ! $? -eq 0 ] && exit 255

hdfs dfs -test -d ./wiki/wc
[ ! $? -eq 0 ] && exit 255
hdfs dfs -test -d ./wiki/allwc
[ ! $? -eq 0 ] && exit 255

hdfs dfs -test -d ./wiki/tfidf
[ ! $? -eq 0 ] && hdfs dfs -mkdir ./wiki/tfidf

hdfs dfs -cat ./wiki/wc/* ./wiki/allwc/*  2>>/dev/null | \
./$1 
# | \
# hdfs dfs -appendToFile - ./wiki/tfidf/output.dat 2>>/dev/null