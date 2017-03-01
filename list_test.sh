#!/bin/bash
DATAFILE="lab2_list.csv"

if [ ! -f $DATAFILE ]
then
	touch $DATAFILE
fi

# single thread tests
for numIters in 10 100 1000 10000 20000
do
	echo "THREADS=1 ITERATIONS=$numIters"
	./lab2_list --iterations=$numIters >> $DATAFILE
done

# list-none-none tests
for numIters in 1 10 100 1000
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters"
		./lab2_list --iterations=$numIters --threads=$numThreads >> $DATAFILE
	done
done

# list-i-none tests
for numIters in 1 2 4 8 16 32
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters YIELD=i"
		./lab2_list --yield=i --iterations=$numIters --threads=$numThreads >> $DATAFILE
	done
done

# list-d-none tests
for numIters in 1 2 4 8 16 32
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters YIELD=d"
		./lab2_list --yield=d --iterations=$numIters --threads=$numThreads >> $DATAFILE
	done
done

# list-il-none tests
for numIters in 1 2 4 8 16 32
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters YIELD=il"
		./lab2_list --yield=il --iterations=$numIters --threads=$numThreads >> $DATAFILE
	done
done

# list-dl-none tests
for numIters in 1 2 4 8 16 32
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters YIELD=dl"
		./lab2_list --yield=dl --iterations=$numIters --threads=$numThreads >> $DATAFILE
	done
done

# list-i-s tests
for numIters in 1 2 4 8 16 32
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters YIELD=i SYNC=s"
		./lab2_list --yield=i --iterations=$numIters --threads=$numThreads --sync=s >> $DATAFILE
	done
done

# list-d-s tests
for numIters in 1 2 4 8 16 32
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters YIELD=d SYNC=s"
		./lab2_list --yield=d --iterations=$numIters --threads=$numThreads --sync=s >> $DATAFILE
	done
done

# list-il-s tests
for numIters in 1 2 4 8 16 32
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters YIELD=il SYNC=s"
		./lab2_list --yield=il --iterations=$numIters --threads=$numThreads --sync=s >> $DATAFILE
	done
done

# list-dl-s tests
for numIters in 1 2 4 8 16 32
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters YIELD=dl SYNC=s"
		./lab2_list --yield=dl --iterations=$numIters --threads=$numThreads --sync=s >> $DATAFILE
	done
done

# list-i-m tests
for numIters in 1 2 4 8 16 32
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters YIELD=i SYNC=m"
		./lab2_list --yield=i --iterations=$numIters --threads=$numThreads --sync=m >> $DATAFILE
	done
done

# list-d-m tests
for numIters in 1 2 4 8 16 32
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters YIELD=d SYNC=m"
		./lab2_list --yield=d --iterations=$numIters --threads=$numThreads --sync=m >> $DATAFILE
	done
done

# list-il-m tests
for numIters in 1 2 4 8 16 32
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters YIELD=il SYNC=m"
		./lab2_list --yield=il --iterations=$numIters --threads=$numThreads --sync=m >> $DATAFILE
	done
done

# list-dl-m tests
for numIters in 1 2 4 8 16 32
do
	for numThreads in 2 4 8 12
	do
		echo "THREADS=$numThreads ITERATIONS=$numIters YIELD=dl SYNC=m"
		./lab2_list --yield=dl --iterations=$numIters --threads=$numThreads --sync=m >> $DATAFILE
	done
done
