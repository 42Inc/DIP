#!/bin/sh
if [ ! $# -eq 1 ]; then
  printf "Usage: ./start-calc-index-wc-top.sh <REDUCER COUNT>\n"
  exit 1
fi

hdfs dfs -rm -r -f ./wiki/top_wc
hdfs dfs -test -d ./wiki/wc
[ ! $? -eq 0 ] && exit 255

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar -files ./wc_top_map.py,./wc_top_red.py \
       -mapper ./wc_top_map.py -reducer ./wc_top_red.py \
       -input ./wiki/wc -output ./wiki/top_wc -numReduceTasks $1
exit $?