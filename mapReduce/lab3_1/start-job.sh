#!/bin/sh

hadoop jar ./bigramcount.jar mapred.bigram.BigramCount -D mapreduce.job.reduces=4 /pub/etwiki.xml bigram/bg ./skip.en



    
    
