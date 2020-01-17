#!/bin/sh

hdfs dfs -rm ./wordcount/output/*
hdfs dfs -rmdir ./wordcount/output
hadoop jar ./wordcount.jar parprog.mapreduce.WordCount -D mapred.reduce.tasks=1 ./wordcount/input ./wordcount/output


    
    
