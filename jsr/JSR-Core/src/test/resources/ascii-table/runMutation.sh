#!/bin/bash
cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" 


PROJECT_NAME="ascii-table"
RESULTS_BASE_DIR="../../results/$PROJECT_NAME"
TEST_SRC_DIR="src/test/java"
TOP_PACKAGE="com"

##########################################################################################################
# Mutation

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "% Starting Mutation Benchmark of $PROJECT_NAME"

##################################################
##### No Zero-Coverage ###########################

echo ""
echo ""
echo "% Running MT on: Checked Coverage w/ Greedy HGS algorithm"

PROJ_DIR=$RESULTS_BASE_DIR/cc/hgs
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '

#############################

echo ""
echo ""
echo "% Running MT on: Checked Coverage w/ Delayed Greedy algorithm"

PROJ_DIR=$RESULTS_BASE_DIR/cc/del
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '


#############################

echo ""
echo ""
echo "% Running MT on: Checked Coverage w/ Genetic algorithm"

PROJ_DIR=$RESULTS_BASE_DIR/cc/genetic
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '


##############################

echo ""
echo ""
echo "% Running MT on: Line Coverage w/ Greedy HGS algorithm"

PROJ_DIR=$RESULTS_BASE_DIR/lc/hgs
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '

#############################

echo ""
echo ""
echo "% Running MT on: Line Coverage w/ Delayed Greedy algorithm"

PROJ_DIR=$RESULTS_BASE_DIR/lc/del
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '


#############################

echo ""
echo ""
echo "% Running MT on: Line Coverage w/ Delayed Greedy algorithm"

PROJ_DIR=$RESULTS_BASE_DIR/lc/genetic
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '


#############################

echo ""
echo ""
echo "% Running MT on: Method Coverage w/ Greedy HGS algorithm"

PROJ_DIR=$RESULTS_BASE_DIR/mc/hgs
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '

#############################

echo ""
echo ""
echo "% Running MT on: Method Coverage w/ Delayed Greedy algorithm"

PROJ_DIR=$RESULTS_BASE_DIR/mc/del
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '


#############################

echo ""
echo ""
echo "% Running MT on: Method Coverage w/ Genetic algorithm"

PROJ_DIR=$RESULTS_BASE_DIR/mc/genetic
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '

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
echo "% Running MT on: Checked Coverage w/ Greedy HGS algorithm (ZERO)"

PROJ_DIR=$RESULTS_BASE_DIR/cc-zero/hgs
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '

#############################

echo ""
echo ""
echo "% Running MT on: Checked Coverage w/ Delayed Greedy algorithm (ZERO)"

PROJ_DIR=$RESULTS_BASE_DIR/cc-zero/del
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '


#############################

echo ""
echo ""
echo "% Running MT on: Checked Coverage w/ Genetic algorithm (ZERO)"

PROJ_DIR=$RESULTS_BASE_DIR/cc-zero/genetic
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '


##############################

echo ""
echo ""
echo "% Running MT on: Line Coverage w/ Greedy HGS algorithm (ZERO)"

PROJ_DIR=$RESULTS_BASE_DIR/lc-zero/hgs
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '

#############################

echo ""
echo ""
echo "% Running MT on: Line Coverage w/ Delayed Greedy algorithm (ZERO)"

PROJ_DIR=$RESULTS_BASE_DIR/lc-zero/del
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '


#############################

echo ""
echo ""
echo "% Running MT on: Line Coverage w/ Genetic algorithm (ZERO)"

PROJ_DIR=$RESULTS_BASE_DIR/lc-zero/genetic
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '


#############################

echo ""
echo ""
echo "% Running MT on: Method Coverage w/ Greedy HGS algorithm (ZERO)"

PROJ_DIR=$RESULTS_BASE_DIR/mc-zero/hgs
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '

#############################

echo ""
echo ""
echo "% Running MT on: Method Coverage w/ Delayed Greedy algorithm (ZERO)"

PROJ_DIR=$RESULTS_BASE_DIR/mc-zero/del
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '


#############################

echo ""
echo ""
echo "% Running MT on: Method Coverage w/ Genetic algorithm (ZERO)"

PROJ_DIR=$RESULTS_BASE_DIR/mc-zero/genetic
OUT_DIR=$PROJ_DIR/mut
mkdir -p $OUT_DIR

touch $OUT_DIR/terminalLog.txt

git reset --hard > $OUT_DIR/terminalLog.txt
cp $PROJ_DIR/gen/$TOP_PACKAGE $TEST_SRC_DIR -r >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt
mvn pitest:mutationCoverage >> $OUT_DIR/terminalLog.txt 2>&1
git reset --hard >> $OUT_DIR/terminalLog.txt

cat $OUT_DIR/terminalLog.txt | grep '>> Line Coverage'
cat $OUT_DIR/terminalLog.txt | grep 'mutations Killed '
cat $OUT_DIR/terminalLog.txt | grep '>> Mutations with'
cat $OUT_DIR/terminalLog.txt | grep '>> Ran '

#############################

echo ""
echo ""
echo "% Resetting project files"
git reset --hard >> $OUT_DIR/terminalLog.txt
mvn clean install >> $OUT_DIR/terminalLog.txt
mvn assembly:single >> $OUT_DIR/terminalLog.txt

echo ""
echo "% Mutation Benchmark Finished"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
