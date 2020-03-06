#!/bin/sh
hdfs dfs -rm -r -f ./output
hdfs dfs -rmdir ./output
hadoop jar ./wordcount.jar parprog.mapreduce.WordCount -D mapred.reduce.tasks=12 ./input ./output
