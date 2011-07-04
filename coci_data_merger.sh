#!/bin/bash

# merges all input files from a COCI contest
# and make one input file and one output file
# for each problem 
#
# usage : ./coci_data_merger FILEPATH

cd $1

for file in *;
do 
    echo $file
    cd $file
    cat *.in.* > $file.in 
    cat *.out.* > $file.out
    cd - 
done

mkdir "data"
for file in *;
do
    if [ $file != "data" ]
    then
        cp $file/$file.in data/$file.in
        cp $file/$file.out data/$file.out
    fi
done 
