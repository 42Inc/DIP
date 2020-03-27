#!/bin/sh
if [ ! $# -eq 2 ]; then
  printf "Usage: ./start-calc-followers-count.sh <REDUCER COUNT> <INPUT HDFS PATH>\n"
  exit 1
fi

hdfs dfs -rm -r -f ./twitter/count_followers
hdfs dfs -test -d ./twitter
[ ! $? -eq 0 ] && hdfs dfs -mkdir ./twitter

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar -files ./count_map.py,./count_red.py \
       -mapper ./count_map.py -reducer ./count_red.py \
       -input $2 -output ./twitter/count_followers -numReduceTasks $1
exit $?