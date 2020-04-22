#!/bin/sh
if [ ! $# -eq 1 ]; then
  printf "Usage: $(echo $0) <REDUCER COUNT>\n"
  exit 1
fi

hdfs dfs -rm -r -f ./wiki/wc
hdfs dfs -test -d ./wiki/precalc
[ ! $? -eq 0 ] && exit 255

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar \
       -files ./wc_index_map.py,./wc_index_red.py \
       -mapper ./wc_index_map.py -reducer ./wc_index_red.py \
       -input ./wiki/precalc -output ./wiki/wc -numReduceTasks $1
exit $?