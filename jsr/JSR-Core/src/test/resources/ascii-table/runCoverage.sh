#!/bin/bash
cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" 

alias jsr='java -jar -Xmx16g ~/workspace/master-jsr/jsr/JSR-CLI/build/libs/JSR-CLI-1.0-SNAPSHOT.jar'

PROJECT_NAME="ascii-table"
TEST_DIR="./src/test/java/"
SRC_DIR="./src/main/java"
CLASS_DIR="target/classes"
JAR_DIR=target/ascii-table-1.2.0-fat-tests.jar
SLICER_DIR="/home/lukas/workspace/master-jsr/slicer/Slicer4J"
PACKAGE="com.github.freva.asciitable"
BASE_OUT_DIR="/home/lukas/workspace/master-benchmark/results/$PROJECT_NAME"

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "% Calculating Coverage Metrics for $PROJECT_NAME"

mkdir -p $BASE_OUT_DIR/lc
mkdir -p $BASE_OUT_DIR/mc
mkdir -p $BASE_OUT_DIR/cc
mkdir -p $BASE_OUT_DIR/lc-zero
mkdir -p $BASE_OUT_DIR/mc-zero
mkdir -p $BASE_OUT_DIR/cc-zero

echo "% > Line Coverage..."


OUT_DIR=$BASE_OUT_DIR/lc

jsr coverage $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --type line  > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'
cat $OUT_DIR/terminalLog.txt | grep 'Coverage Calculation took'

echo "% > Method Coverage..."


OUT_DIR=$BASE_OUT_DIR/mc

jsr coverage $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --type method  > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'
cat $OUT_DIR/terminalLog.txt | grep 'Coverage Calculation took'


echo "% > Checked Coverage..."

OUT_DIR=$BASE_OUT_DIR/cc

jsr coverage $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --type checked  > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'calculateOverallCoverage()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'
cat $OUT_DIR/terminalLog.txt | grep 'Coverage Calculation took'

echo ""
echo "% Finished"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
