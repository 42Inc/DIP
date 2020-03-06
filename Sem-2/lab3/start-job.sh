#!/bin/sh
hdfs dfs -rm -r -f ./maxtemp/output
hadoop jar ./maxtemp.jar parprog.mapreduce.MaxTemp -D mapred.reduce.tasks=0 ./maxtemp/input ./maxtemp/output
