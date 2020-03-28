#!/bin/sh
if [ ! $# -eq 1 ]; then
  printf "Usage: ./start-calc-followers-av.sh <REDUCER COUNT>\n"
  exit 1
fi

hdfs dfs -rm -r -f ./twitter/av_followers
hdfs dfs -test -d ./twitter/count_followers
[ ! $? -eq 0 ] && exit 255

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar -files ./av_map.py,./av_red.py \
       -mapper ./av_map.py -reducer ./av_red.py \
       -input ./twitter/count_followers -output ./twitter/av_followers -numReduceTasks $1
exit $?