#!/bin/bash

PROJECT_NAME="lambdaj"
RESULTS_BASE_DIR="../../results/$PROJECT_NAME"
TEST_SRC_DIR="src/test/java"
TOP_PACKAGE="ch"

##########################################################################################################
# Mutation

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "% Starting Mutation Testing of $PROJECT_NAME"

CROSSOVER=(0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0)
MUTATION=(0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0)

for crossoverrate in ${CROSSOVER[@]}
do
  for mutationrate in ${MUTATION[@]}
  do
    echo ""
    echo ""
    echo "% Running MT on: Line Coverage w/ Genetic algorithm"

    PROJ_DIR=$RESULTS_BASE_DIR/lc/genetic_${crossoverrate}_$mutationrate
    OUT_DIR=$PROJ_DIR/mut_rts
    mkdir -p $OUT_DIR

    touch $OUT_DIR/terminalLogMutation.txt

    git reset --hard > $OUT_DIR/terminalLogMutation.txt
    cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLogMutation.txt
    mvn clean install >> $OUT_DIR/terminalLogMutation.txt
    mvn assembly:single >> $OUT_DIR/terminalLogMutation.txt
    mvn pitest:mutationCoverage >> $OUT_DIR/terminalLogMutation.txt 2>&1
    git reset --hard >> $OUT_DIR/terminalLogMutation.txt

    cat $OUT_DIR/terminalLogMutation.txt | grep '>> Line Coverage'
    cat $OUT_DIR/terminalLogMutation.txt | grep 'mutations Killed '
    cat $OUT_DIR/terminalLogMutation.txt | grep '>> Mutations with'
    cat $OUT_DIR/terminalLogMutation.txt | grep '>> Ran '
  done
done

#############################

echo ""
echo ""
echo "% Resetting project files"
git reset --hard >> $OUT_DIR/terminalLogMutation.txt
mvn clean install >> $OUT_DIR/terminalLogMutation.txt
mvn assembly:single >> $OUT_DIR/terminalLogMutation.txt

echo ""
echo "% Mutation Finished"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
