#!/bin/sh
if [ ! $# -eq 1 ]; then
  printf "Usage: $(echo $0) <REDUCER COUNT>\n"
  exit 1
fi

hdfs dfs -rm -r -f ./wiki/top_allwc
hdfs dfs -test -d ./wiki/allwc
[ ! $? -eq 0 ] && exit 255

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar -files ./allwc_top_map.py,./allwc_top_red.py \
       -mapper ./allwc_top_map.py -reducer ./allwc_top_red.py \
       -input ./wiki/allwc -output ./wiki/top_allwc -numReduceTasks $1
exit $?