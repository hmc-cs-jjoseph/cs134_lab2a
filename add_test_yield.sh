#!/bin/bash
DATAFILE="lab2_add.csv"

if [ -f $DATAFILE ]
then
	rm $DATAFILE
fi

touch lab2_add.csv

for numIters in 100 1000 10000 100000
do
	for numThreads in {1..10}
	do
		./lab2_add --yield --iterations=$numIters --threads=$numThreads >> lab2_add.csv
	done
done


