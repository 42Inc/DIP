#!/bin/sh

hdfs dfs -rm ./topwords/output/*
hdfs dfs -rmdir ./topwords/output
hadoop jar ./topwords.jar parprog.mapreduce.TopWords -D mapred.reduce.tasks=1 ./topwords/input ./topwords/output



    
    
