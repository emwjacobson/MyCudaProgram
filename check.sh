#!/bin/bash

checks="cudaMallocManaged cudaStreamCreate"
logfile=output.log

if [ $# -lt 1 ]; then
    echo "Usage: $0 [program]"
    exit 1
fi

if [ ! -x $1 ]; then
    echo "Cannot execute file '$1'. Check for execute permissions."
    exit 1
fi

print_header() {
    lightcyan='\033[1;36m'
    nocolor='\033[0m'
    echo -e "${lightcyan}$1${nocolor}"
}

cleanup() {
    rm $logfile
}

nvprof --log-file $logfile ./$1 2> /dev/stdout 1> /dev/null


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