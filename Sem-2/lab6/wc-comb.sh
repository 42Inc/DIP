#!/bin/sh
if [ ! $# -eq 1 ]; then
  printf "Usage: $(echo $0) <REDUCER COUNT>\n"
  exit 1
fi

hdfs dfs -rm -r -f ./wiki/wc_comb
hdfs dfs -test -d ./wiki/precalc
[ ! $? -eq 0 ] && exit 255
hdfs dfs -test -f ./wiki/doc_count/output.dat
[ ! $? -eq 0 ] && exit 254
hdfs dfs -test -d ./wiki/top_allwc
[ ! $? -eq 0 ] && exit 253

cp wc_comb_red.py.tpl wc_comb_red.py
sed -i "s/DOCUMENTS_COUNT/$(hdfs dfs -cat ./wiki/doc_count/output.dat 2>>/dev/null)/g" wc_comb_red.py
sed -i "s/MATCHER_REGEX/$(hdfs dfs -cat ./wiki/top_allwc/part-00000 2>>/dev/null | sed 's/\t//g')/g" wc_comb_red.py

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar \
       -files ./wc_comb_map.py,./wc_comb_red.py \
       -mapper ./wc_comb_map.py -reducer ./wc_comb_red.py \
       -input ./wiki/precalc -output ./wiki/wc_comb -numReduceTasks $1

exit $?
