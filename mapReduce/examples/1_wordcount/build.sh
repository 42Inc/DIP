#!/bin/sh

JARS=`yarn classpath`

javac -classpath $JARS -d classes WordCount.java
jar -cvf wordcount.jar -C classes .

