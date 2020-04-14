#!/bin/sh
if [ ! $# -eq 1 ]; then
  printf "Usage: ./start-calc-all-wc-invert-index.sh <REDUCER COUNT>\n"
  exit 1
fi

hdfs dfs -rm -r -f ./wiki/allwc
hdfs dfs -test -d ./wiki/precalc
[ ! $? -eq 0 ] && exit 255

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar \
       -files ./allwc_index_map.py,./allwc_index_red.py \
       -mapper ./allwc_index_map.py -reducer ./allwc_index_red.py \
       -input ./wiki/precalc -output ./wiki/allwc -numReduceTasks $1
exit $?