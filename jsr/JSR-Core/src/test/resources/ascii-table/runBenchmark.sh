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

##########################################################################################################
# Reduction

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "% Starting TSR Benchmark of $PROJECT_NAME"

##################################################
##### No Zero-Coverage ###########################

echo ""
echo ""
echo "% Checked Coverage w/ Greedy HGS algorithm"

OUT_DIR=$BASE_OUT_DIR/cc/hgs
COV_REP_DIR=$BASE_OUT_DIR/cc/coverage/CheckedCoverageReport.cvg
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm greedyHGS > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'

#############################

echo ""
echo ""
echo "% Checked Coverage w/ Delayed Greedy algorithm"

OUT_DIR=$BASE_OUT_DIR/cc/del
COV_REP_DIR=$BASE_OUT_DIR/cc/coverage/CheckedCoverageReport.cvg
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm delayedGreedy > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'reduce()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'


#############################

echo ""
echo ""
echo "% Checked Coverage w/ Genetic algorithm"

OUT_DIR=$BASE_OUT_DIR/cc/genetic 
COV_REP_DIR=$BASE_OUT_DIR/cc/coverage/CheckedCoverageReport.cvg
echo $OUT_DIR
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm genetic > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'forEachRemaining()'
cat $OUT_DIR/terminalLog.txt | grep 'reduce()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'


##############################

echo ""
echo ""
echo "% Line Coverage w/ Greedy HGS algorithm"

OUT_DIR=$BASE_OUT_DIR/lc/hgs
COV_REP_DIR=$BASE_OUT_DIR/lc/coverage/LineCoverageReport.cvg

mkdir -p $OUT_DIR


touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm greedyHGS > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'

#############################

echo ""
echo ""
echo "% Line Coverage w/ Delayed Greedy algorithm"

OUT_DIR=$BASE_OUT_DIR/lc/del
COV_REP_DIR=$BASE_OUT_DIR/lc/coverage/LineCoverageReport.cvg
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm delayedGreedy > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'reduce()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'


#############################

echo ""
echo ""
echo "% Line Coverage w/ Genetic algorithm"

OUT_DIR=$BASE_OUT_DIR/lc/genetic 
COV_REP_DIR=$BASE_OUT_DIR/lc/coverage/LineCoverageReport.cvg

mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm genetic > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()' 
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'forEachRemaining()'
cat $OUT_DIR/terminalLog.txt | grep 'reduce()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'


#############################

echo ""
echo ""
echo "% Method Coverage w/ Greedy HGS algorithm"

OUT_DIR=$BASE_OUT_DIR/mc/hgs
COV_REP_DIR=$BASE_OUT_DIR/mc/coverage/MethodCoverageReport.cvg
mkdir -p $OUT_DIR


touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm greedyHGS > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'

#############################

echo ""
echo ""
echo "% Method Coverage w/ Delayed Greedy algorithm"

OUT_DIR=$BASE_OUT_DIR/mc/del
COV_REP_DIR=$BASE_OUT_DIR/mc/coverage/MethodCoverageReport.cvg
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm delayedGreedy > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'reduce()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'


#############################

echo ""
echo ""
echo "% Method Coverage w/ Genetic algorithm"

OUT_DIR=$BASE_OUT_DIR/mc/genetic 
COV_REP_DIR=$BASE_OUT_DIR/mc/coverage/MethodCoverageReport.cvg
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm genetic > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'forEachRemaining()'
cat $OUT_DIR/terminalLog.txt | grep 'reduce()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'

########################################################
##### WITH Zero-Coverage TCs ###########################

echo ""
echo ""
echo ""
echo ""
echo ""
echo "% And everything again with KEEP ZERO Coverage TCs enabled"
echo ""
echo ""
echo ""
echo ""
echo ""
echo "% Checked Coverage w/ Greedy HGS algorithm (ZERO)"

OUT_DIR=$BASE_OUT_DIR/cc-zero/hgs
COV_REP_DIR=$BASE_OUT_DIR/cc/coverage/CheckedCoverageReport.cvg
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm greedyHGS --zero > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'getRemovedTCs()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'

#############################

echo ""
echo ""
echo "% Checked Coverage w/ Delayed Greedy algorithm (ZERO)"

OUT_DIR=$BASE_OUT_DIR/cc-zero/del
COV_REP_DIR=$BASE_OUT_DIR/cc/coverage/CheckedCoverageReport.cvg
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm delayedGreedy --zero > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'reduce()'
cat $OUT_DIR/terminalLog.txt | grep 'getRemovedTCs()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'


#############################

echo ""
echo ""
echo "% Checked Coverage w/ Genetic algorithm (ZERO)"

OUT_DIR=$BASE_OUT_DIR/cc-zero/genetic 
COV_REP_DIR=$BASE_OUT_DIR/cc/coverage/CheckedCoverageReport.cvg
echo $OUT_DIR
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm genetic --zero > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'forEachRemaining()'
cat $OUT_DIR/terminalLog.txt | grep 'reduce()'
cat $OUT_DIR/terminalLog.txt | grep 'getRemovedTCs()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'


##############################

echo ""
echo ""
echo "% Line Coverage w/ Greedy HGS algorithm (ZERO)"

OUT_DIR=$BASE_OUT_DIR/lc-zero/hgs
COV_REP_DIR=$BASE_OUT_DIR/lc/coverage/LineCoverageReport.cvg

mkdir -p $OUT_DIR


touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm greedyHGS --zero > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'getRemovedTCs()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'

#############################

echo ""
echo ""
echo "% Line Coverage w/ Delayed Greedy algorithm (ZERO)"

OUT_DIR=$BASE_OUT_DIR/lc-zero/del
COV_REP_DIR=$BASE_OUT_DIR/lc/coverage/LineCoverageReport.cvg
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm delayedGreedy --zero > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'getRemovedTCs()'
cat $OUT_DIR/terminalLog.txt | grep 'reduce()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'


#############################

echo ""
echo ""
echo "% Line Coverage w/ Genetic algorithm (ZERO)"

OUT_DIR=$BASE_OUT_DIR/lc-zero/genetic 
COV_REP_DIR=$BASE_OUT_DIR/lc/coverage/LineCoverageReport.cvg

mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm genetic --zero > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()' 
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'forEachRemaining()'
cat $OUT_DIR/terminalLog.txt | grep 'getRemovedTCs()'
cat $OUT_DIR/terminalLog.txt | grep 'reduce()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'


#############################

echo ""
echo ""
echo "% Method Coverage w/ Greedy HGS algorithm (ZERO)"

OUT_DIR=$BASE_OUT_DIR/mc-zero/hgs
COV_REP_DIR=$BASE_OUT_DIR/mc/coverage/MethodCoverageReport.cvg
mkdir -p $OUT_DIR


touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm greedyHGS --zero > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'getRemovedTCs()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'

#############################

echo ""
echo ""
echo "% Method Coverage w/ Delayed Greedy algorithm (ZERO)"

OUT_DIR=$BASE_OUT_DIR/mc-zero/del
COV_REP_DIR=$BASE_OUT_DIR/mc/coverage/MethodCoverageReport.cvg
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm delayedGreedy --zero > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'getRemovedTCs()'
cat $OUT_DIR/terminalLog.txt | grep 'reduce()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'


#############################

echo ""
echo ""
echo "% Method Coverage w/ Genetic algorithm (ZERO)"

OUT_DIR=$BASE_OUT_DIR/mc-zero/genetic 
COV_REP_DIR=$BASE_OUT_DIR/mc/coverage/MethodCoverageReport.cvg
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt
jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm genetic --zero > $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep 'mergePartialSuites()'
cat $OUT_DIR/terminalLog.txt | grep 'assembleReport()'
cat $OUT_DIR/terminalLog.txt | grep 'forEachRemaining()'
cat $OUT_DIR/terminalLog.txt | grep 'getRemovedTCs()'
cat $OUT_DIR/terminalLog.txt | grep 'reduce()'
cat $OUT_DIR/terminalLog.txt | grep 'logTime()'
cat $OUT_DIR/terminalLog.txt | grep '^| [A-Z]'


echo ""
echo "% Finished"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
