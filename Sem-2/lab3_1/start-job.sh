#!/bin/sh
hdfs dfs -rm -r -f ./bigram/output
#hadoop jar ./bigramcount.jar mapred.bigram.BigramCount -D mapreduce.job.reduces=4 /pub/etwiki.xml ./bigram/bg ./skip.en 
hadoop jar ./bigramcount.jar mapred.bigram.BigramCount -D mapreduce.job.reduces=4 /user/doshinsky/wordcount/input/texts/orwell1984.txt ./bigram/output ./skip.ru



    
    
