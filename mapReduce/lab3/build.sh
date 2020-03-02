#!/bin/sh

JARS=`yarn classpath`

javac -classpath $JARS -d classes MaxTemp.java
jar -cvf maxtemp.jar -C classes .

