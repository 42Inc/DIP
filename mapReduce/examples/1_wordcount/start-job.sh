#!/bin/sh

hdfs dfs -rm ./output/*
hdfs dfs -rmdir ./output
hadoop jar ./wordcount.jar parprog.mapreduce.WordCount -D mapred.reduce.tasks=2 ./input ./output
