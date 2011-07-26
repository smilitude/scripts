#!/bin/bash

# This bash script compiles and run a program
# over multiple files and prints if it produced
# correct output for all the files or not
# USAGE: ./runprog.sh [cpp/java]


#cleaning up
if [ -d my ]
then 
    rm -r my
fi

if [ -f check.class ]
then
    rm check.class
fi

if [ -f a.out ]
then
    rm a.out
fi

TOTALCASE=20

# compilation
if [ $1 == "cpp" ]
then
    g++ check.cpp
    if [ -f a.out ]
    then
        echo "compiled successfully"
    else 
        echo "compile error"
        exit 0
    fi
    runfile="./a.out"
elif [ $1 == "java" ]
then
    javac check.java
    if [ -f check.class ]
    then
        echo "compiled successfully"
    else 
        echo "compile error"
        exit 0
    fi
    runfile="java check"
else
    echo "USAGE: ./check.sh [cpp/java]"
    exit 0
fi

mkdir my

# produce output files
for ((  i = 1 ;  i <= $TOTALCASE;  i++  )) 
do
    if [ $i -lt 10 ]
    then
        infile="0$i"
    else 
        infile="$i"
    fi
    
    fmt="case $infile: %e seconds"
    /usr/bin/time -f "$fmt" $runfile < tests/$infile > my/$infile.a
done

# check if it crashed 
totalfile=$(ls -1 my| wc -l)
if [ $totalfile -ne $TOTALCASE ] 
then
    echo "program crashed in case " + $(( $totalfile+1 ))
    exit 0
else
    echo "run successful - total files "$totalfile
fi


# check if the answers are correct
for ((  i = 1 ;  i <= $TOTALCASE;  i++  )) 
do
    if [ $i -lt 10 ]
    then
        infile="0$i"
    else 
        infile="$i"
    fi
    
    if diff tests/$infile.a my/$infile.a >/dev/null 
    then 
        echo $infile" OK" 
    else
        echo $infile" Wrong Answer"
        exit 0
    fi
done

echo "Passed all cases"

