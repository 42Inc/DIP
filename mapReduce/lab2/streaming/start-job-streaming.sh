#!/bin/sh

hadoop jar /opt/hadoop/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar -file ./mapper.py -mapper ./mapper.py \
       -file ./reducer.py -combiner ./reducer.py -reducer ./reducer.py \
       -input ./wordcount/input -output ./wordcount/output -numReduceTasks 1
              
    
    
