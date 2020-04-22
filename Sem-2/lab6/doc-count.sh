#!/bin/sh
if [ ! $# -eq 1 ]; then
  printf "Usage: $(echo $0) <script name>\n"
  exit 1
fi

test -f $1
[ ! $? -eq 0 ] && exit 255

hdfs dfs -test -d ./wiki/wc
[ ! $? -eq 0 ] && exit 254

hdfs dfs -test -d ./wiki/doc_count
[ ! $? -eq 0 ] && hdfs dfs -mkdir ./wiki/doc_count

hdfs dfs -test -f ./wiki/doc_count/output.dat
[ $? -eq 0 ] && hdfs dfs -rm -f ./wiki/doc_count/*

hdfs dfs -cat ./wiki/wc/*  2>>/dev/null | \
./$1 | \
hdfs dfs -appendToFile - ./wiki/doc_count/output.dat 2>>/dev/null

exit $?