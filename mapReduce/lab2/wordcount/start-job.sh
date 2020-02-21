#!/bin/sh

hdfs dfs -rm -r ./wordcount/output
hadoop jar ./wordcount.jar ddpcourse.mapred.WordCount -D mapred.reduce.tasks=2 ./wordcount/input ./wordcount/output


    
    
