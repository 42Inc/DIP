#!/bin/sh
if [ ! $# -eq 1 ]; then
  printf "Usage: ./start-calc-followers-dist.sh <REDUCER COUNT>\n"
  exit 1
fi

hdfs dfs -rm -r -f ./twitter/dist_followers
hdfs dfs -test -d ./twitter/count_followers
[ ! $? -eq 0 ] && exit 255

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar -files ./dist_map.py,./dist_red.py \
       -mapper ./dist_map.py -reducer ./dist_red.py \
       -input ./twitter/count_followers -output ./twitter/dist_followers -numReduceTasks $1
exit $?