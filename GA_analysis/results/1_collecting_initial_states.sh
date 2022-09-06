#!/bin/bash

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "% Collecting initial states"


touch initial_states.txt

echo "ID,Project,TS,Total Lines,Covered Lines,Line Coverage,Total Mutants, killed Mutants,Mutationscore" > initial_states.txt


PROJECT=("commons-lang" "commons-io" "lambdaj" "exp4j" "commons-cli" "commons-csv" "minimal-json" "java-tuple" "json-simple" "confucius" "ascii-table")

count=1
for current_project in ${PROJECT[@]}
do
    DIR=${current_project}/lc/mut
    lines=$(grep -m 1 "Line Coverage" $DIR/terminalLogMutation.txt | cut -d " " -f 4 | cut -d "/" -f 2)
    ts=$(grep -m 1 "It contains" ${current_project}/lc/terminalLogCoverage.txt | cut -d " " -f 10)
    covered=$(grep -m 1 "Line Coverage" $DIR/terminalLogMutation.txt | cut -d " " -f 4 | cut -d "/" -f 1)
    mutants=$(grep -m 1 "mutations Killed" $DIR/terminalLogMutation.txt | cut -d " " -f 3)
    killed=$(grep -m 1 "mutations Killed" $DIR/terminalLogMutation.txt | cut -d " " -f 6)
    coverage=$(bc <<< "scale=4; $((covered)) / $((lines))")
    echo -n "$count," >> initial_states.txt
    echo -n "$current_project," >> initial_states.txt
    echo -n "$ts," >> initial_states.txt
    echo -n "$lines," >> initial_states.txt
    echo -n "$covered," >> initial_states.txt
    echo -n "$coverage," >> initial_states.txt
    echo -n "$mutants," >> initial_states.txt
    echo -n "$killed," >> initial_states.txt
    bc <<< "scale=4; $((killed)) / $((mutants))" >> initial_states.txt
    count=$((count+1))
done

cat initial_states.txt > initial_states.csv

echo ""
echo "% Finished"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
