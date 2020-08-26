#!/bin/bash

# This script checks whether or not certain features are being used in the cuda program.
# It uses the output of nvprof and checks for certain keywords, and how many times they are used.

# `checks` is a list of strings that you want to search for in the nvprof output
checks="cudaMallocManaged cudaStreamCreate"
logfile=output.log

# If not enough arguments, print error and exit
if [ $# -lt 1 ]; then
    echo "Usage: $0 [program]"
    exit 1
fi

# If specified file is not executable, print error and exit
if [ ! -x $1 ]; then
    echo "Cannot execute file '$1'. Check for execute permissions."
    exit 1
fi

# Function to help print text in pretty colors
print_header() {
    lightcyan='\033[1;36m'
    nocolor='\033[0m'
    echo -e "${lightcyan}$1${nocolor}"
}

# Cleanup function to remove log file before exiting
cleanup() {
    rm $logfile
}

# Run nvprof, log output to $logfile
nvprof --log-file $logfile ./$1 2> /dev/stdout 1> /dev/null

# For each of the strings to check for, check and print how many times they were used
for c in $checks; do
    res=$(cat $logfile | grep $c | awk '{print $3}')
    echo -n "Used $c? "

    if [ ! -z $res ] && [ $res -gt 0 ]; then
        echo "Yes"
        echo -e "\tUsed $res times."
    else
        echo "No"
    fi
done

trap cleanup EXIT