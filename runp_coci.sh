#!/bin/bash

# This bash script compiles and run a program
# over multiple files for COCI and prints if it produced
# correct output for all the files or not
# USAGE: ./runp_coci.sh [cpp/java]
# you have to put the source in check.cpp / check.java


#config lines - the lines that you MUST edit
TOTALCASE=10
NAME="tenis"


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
    infile="$NAME/$NAME.in.$i"
    
    fmt="case $i: %e seconds"
    /usr/bin/time -f "$fmt" $runfile < $infile > my/$NAME.out.$i
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


PASSED=0;

# check if the answers are correct
for ((  i = 1 ;  i <= $TOTALCASE;  i++  )) 
do
    infile="$NAME/$NAME.in.$i"
    
    if diff $NAME/$NAME.out.$i my/$NAME.out.$i >/dev/null 
    then 
        echo $i" OK" 
        PASSED=$(($PASSED+1));
    else
        echo $i" Wrong Answer"
    fi
done

if [ $PASSED == $TOTALCASE ] 
then
    echo "passed all cases"
else 
    echo passed $PASSED out of $TOTALCASE
fi
