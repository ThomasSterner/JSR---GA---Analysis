#!/bin/bash

jsr="java -jar -Xmx16g ${HOME}/Desktop/JSR/JSR---GA---Analysis/jsr/JSR-CLI/build/libs/JSR-CLI-1.0-SNAPSHOT.jar"

PROJECT_NAME="exp4j"
TEST_DIR="$PWD/src/test/java/"
SRC_DIR="$PWD/src/main/java"
CLASS_DIR="$PWD/target/classes"
JAR_DIR="$PWD/target/exp4j-0.4.9-SNAPSHOT-fat-tests.jar"
SLICER_DIR="$HOME/Desktop/JSR/JSR---GA---Analysis/slicer/Slicer4J"
PACKAGE="net.objecthunter.exp4j"
BASE_OUT_DIR="$HOME/Desktop/JSR/JSR---GA---Analysis/GA_analysis/results/$PROJECT_NAME"

##########################################################################################################
# Reduction

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "% Starting TSR of $PROJECT_NAME"

CROSSOVER=(0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0)
MUTATION=(0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0)

for crossoverrate in ${CROSSOVER[@]}
do
  for mutationrate in ${MUTATION[@]}
  do
    OUT_DIR=$BASE_OUT_DIR/lc/genetic_${crossoverrate}_$mutationrate
    COV_REP_DIR=$BASE_OUT_DIR/lc/coverage/LineCoverageReport.cvg
    echo ""
    echo ""
    echo "% Line Coverage - Genetic algorithm - Crossover: $crossoverrate - Mutation: $mutationrate"

    mkdir -p $OUT_DIR
    touch $OUT_DIR/terminalLogReducedTS.txt
    $jsr reduce $TEST_DIR -c $CLASS_DIR -j $JAR_DIR -l $SLICER_DIR -s $SRC_DIR --package $PACKAGE -o $OUT_DIR --gen $OUT_DIR/gen --report $COV_REP_DIR --algorithm genetic --mutation $mutationrate --crossover $crossoverrate> $OUT_DIR/terminalLogReducedTS.txt

    cat $OUT_DIR/terminalLogReducedTS.txt | grep 'mergePartialSuites()' 
    cat $OUT_DIR/terminalLogReducedTS.txt | grep 'assembleReport()'
    cat $OUT_DIR/terminalLogReducedTS.txt | grep 'forEachRemaining()'
    cat $OUT_DIR/terminalLogReducedTS.txt | grep 'reduce()'
    cat $OUT_DIR/terminalLogReducedTS.txt | grep 'logTime()'
    cat $OUT_DIR/terminalLogReducedTS.txt | grep '^| [A-Z]'
  done
done


echo ""
echo "% Finished"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
