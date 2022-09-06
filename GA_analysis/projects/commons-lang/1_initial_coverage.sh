#!/bin/bash

jsr="java -jar -Xmx16g ${HOME}/Desktop/JSR/JSR---GA---Analysis/jsr/JSR-CLI/build/libs/JSR-CLI-1.0-SNAPSHOT.jar"

PROJECT_NAME="commons-lang"
TEST_DIR="$PWD/src/test/java/"
SRC_DIR="$PWD/src/main/java"
CLASS_DIR="$PWD/target/classes"
JAR_DIR="$PWD/target/commons-lang3-3.4-fat-tests.jar"
SLICER_DIR="$HOME/Desktop/JSR/JSR---GA---Analysis/slicer/Slicer4J"
PACKAGE="org.apache.commons"
BASE_OUT_DIR="$HOME/Desktop/JSR/JSR---GA---Analysis/GA_analysis/results/$PROJECT_NAME"

##########################################################################################################
# Reduction

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "% Calculating Line Coverage for $PROJECT_NAME"

mkdir -p $BASE_OUT_DIR/lc

mvn clean install

echo "% > Line Coverage..."


OUT_DIR=$BASE_OUT_DIR/lc

$jsr coverage $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --type line  > $OUT_DIR/terminalLogCoverage.txt

cat $OUT_DIR/terminalLogCoverage.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLogCoverage.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLogCoverage.txt | grep 'logTime()'
cat $OUT_DIR/terminalLogCoverage.txt | grep '^| [A-Z]'
cat $OUT_DIR/terminalLogCoverage.txt | grep 'Coverage Calculation took'


OUT_DIR=$BASE_OUT_DIR/lc/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLogMutation.txt

mvn clean install >> $OUT_DIR/terminalLogMutation.txt
mvn assembly:single >> $OUT_DIR/terminalLogMutation.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLogMutation.txt 2>&1

cat $OUT_DIR/terminalLogMutation.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLogMutation.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLogMutation.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLogMutation.txt | grep '>> Ran '

echo ""
echo "% Finished"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
