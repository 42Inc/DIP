#!/bin/sh

JARS=`yarn classpath`

javac -classpath $JARS -d classes TopWords.java
jar -cvf topwords.jar -C classes .

