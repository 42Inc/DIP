#!/bin/sh
if [ ! $# -eq 1 ]; then
  printf "Usage: ./start-calc-followers-top.sh <REDUCER COUNT>\n"
  exit 1
fi

hdfs dfs -rm -r -f ./twitter/top_followers
hdfs dfs -test -d ./twitter/count_followers
[ ! $? -eq 0 ] && exit 255

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar -files ./top_map.py,./top_red.py \
       -mapper ./top_map.py -reducer ./top_red.py \
       -input ./twitter/count_followers -output ./twitter/top_followers -numReduceTasks $1
exit $?