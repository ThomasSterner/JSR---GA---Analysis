#!/bin/bash

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "% Collecting RTS states"

touch rts_states.txt

echo "Run,Crossoverrate,Mutationrate,TS,RTS,Mutation Score,Time" > rts_states.txt

MUTATION=(0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0)
CROSSOVER=(0.0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0)
count=1
for crossoverrate in ${CROSSOVER[@]}
do
  for mutationrate in ${MUTATION[@]}
  do
    DIR=genetic_${crossoverrate}_$mutationrate
    MUT=$DIR/mut_rts
    mutants=$(grep -m 1 "mutations Killed" $MUT/terminalLogMutation.txt | cut -d " " -f 3)
    killed=$(grep -m 1 "mutations Killed" $MUT/terminalLogMutation.txt | cut -d " " -f 6)
    mutationscore=$(bc <<< "scale=4; $((killed)) / $((mutants))")
    echo -n "$count," >> rts_states.txt
    grep -i "Wrote reduced test suite" $DIR/terminalLogReducedTS.txt | cut -d "_" -f 4 | tr "\n" "," >> rts_states.txt
    grep -i "Wrote reduced test suite" $DIR/terminalLogReducedTS.txt | cut -d "_" -f 5 | cut -d "/" -f 1 | tr "\n" "," >> rts_states.txt
    grep -i "Test Suite size" $DIR/terminalLogReducedTS.txt | cut -d":" -f 2 | cut -d " " -f 2 | tr "\n" "," >> rts_states.txt
    grep -i "relevant test cases" $DIR/terminalLogReducedTS.txt | cut -d " " -f 3 | tr "\n" "," >> rts_states.txt
    echo -n "$mutationscore," >> rts_states.txt
    grep -i "* Overall" $DIR/terminalLogReducedTS.txt | cut -d ":" -f 4 | cut -d " " -f 2 >> rts_states.txt
    
    count=$((count+1))
  done
done

cat rts_states.txt > rts_states.csv

echo ""
echo "% Finished"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
