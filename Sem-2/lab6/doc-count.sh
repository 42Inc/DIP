#!/bin/sh
if [ ! $# -eq 1 ]; then
  printf "Usage: $(echo $0) <REDUCER COUNT>\n"
  exit 1
fi

hdfs dfs -rm -r -f ./wiki/doc_count
hdfs dfs -test -d ./wiki/wc
[ ! $? -eq 0 ] && exit 255

hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar -files ./doc_count_map.py,./doc_count_red.py \
       -mapper ./doc_count_map.py -reducer ./doc_count_red.py \
       -input ./wiki/wc -output ./wiki/doc_count -numReduceTasks $1
       
exit $?

# if [ ! $# -eq 1 ]; then
#   printf "Usage: $(echo $0) <script name>\n"
#   exit 1
# fi

# test -f $1
# [ ! $? -eq 0 ] && exit 255

# hdfs dfs -test -d ./wiki/wc
# [ ! $? -eq 0 ] && exit 254

# hdfs dfs -test -d ./wiki/doc_count
# [ ! $? -eq 0 ] && hdfs dfs -mkdir ./wiki/doc_count

# hdfs dfs -test -f ./wiki/doc_count/output.dat
# [ $? -eq 0 ] && hdfs dfs -rm -r -f ./wiki/doc_count/output.dat

# hdfs dfs -cat ./wiki/wc/*  2>>/dev/null | \
# ./$1 | \
# hdfs dfs -appendToFile - ./wiki/doc_count/output.dat 2>>/dev/null

# exit $?