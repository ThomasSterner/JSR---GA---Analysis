#!/bin/bash

echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "% Collecting all rts states for analysis"


PROJECT=("exp4j" "commons-cli" "commons-csv" "minimal-json" "java-tuple" "json-simple" "confucius" "ascii-table")


for current_project in ${PROJECT[@]}
do
    cp ${current_project}/lc/rts_states.csv ${current_project}_rts_states.csv
done

echo ""
echo "% Finished"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
