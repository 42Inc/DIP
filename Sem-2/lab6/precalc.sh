#!/bin/sh
if [ ! $# -eq 1 ]; then
  printf "Usage: ./start-precalc-invert-index.sh <INPUT HDFS PATH>\n"
  exit 1
fi

hdfs dfs -rm -r -f ./wiki/precalc
hdfs dfs -test -d ./wiki
[ ! $? -eq 0 ] && hdfs dfs -mkdir ./wiki

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar \
       -libjars ./XmlInputFormat.jar \
       -files ./pre_index_map.py \
       -inputformat "pdccourse.hw3.XmlInputFormat" \
       -mapper ./pre_index_map.py \
       -input $1 -output ./wiki/precalc -numReduceTasks 0
exit $?