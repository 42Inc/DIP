#!/bin/sh
[ ! -d ./classes ] && mkdir classes
JARS=`yarn classpath`:/opt/hadoop/share/hadoop/tools/lib/*

javac -classpath $JARS -d classes XmlInputFormat.java
jar -cvf XmlInputFormat.jar -C classes .
