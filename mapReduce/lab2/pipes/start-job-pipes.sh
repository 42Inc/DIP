#!/bin/sh

hadoop pipes -D hadoop.pipes.java.recordreader=true -D hadoop.pipes.java.recordwriter=true \
       -program ./wordcount/bin/wordcount -reduces 1 \
       -input ./wordcount/input -output ./wordcount/output
