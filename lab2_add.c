#include <stdlib.h>
#include <pthread.h>
#include <stdio.h>
#include <getopt.h>
#include <time.h>

struct threadArgs{
	long long *counter;
	size_t iterations;
};

int opt_yield;
void add(long long *pointer, long long value) {
	long long sum = *pointer + value;
	if (opt_yield) {
		sched_yield();
	}
	*pointer = sum;
}

void *addToCounter(void *args) {
	struct threadArgs *argStruct = (struct threadArgs *) args;
	long long *counter = (long long *) argStruct->counter;
	size_t iterations = (size_t) argStruct->iterations;
	for(size_t i = 0; i < iterations; ++i) {
		add(counter, 1);
	}
	for(size_t i = 0; i < iterations; ++i) {
		add(counter, -1);
	}
	return (void *) args;
}

struct programArgs{
	size_t iterations;
	size_t threads;
	size_t testID;
};

void getArguments(struct programArgs *arguments, int argc, char **argv) {
	arguments->iterations = 1;
	arguments->threads = 1;
	arguments->testID = 0;
	char opt;
	int optind;
  struct option options[] = {
    {"threads", required_argument, 0, 't'},
    {"iterations", required_argument, 0, 'i'},
		{"yield", no_argument, 0, 'y'},
    {0, 0, 0, 0}};
  while((opt = getopt_long(argc, argv, "t:i:", options, &optind)) != -1) {
    switch(opt) {
			case 'y':
				arguments->testID = 1;
				break;
      case 't':
				arguments->threads = (size_t) atoi(optarg);
      	break;
			case 'i':
				arguments->iterations = (size_t) atoi(optarg);
				break;
      case '?':
				fprintf(stderr, "Usage: ./lab2_add --threads=<n threads> --iterations=<k iterations>\n");
				exit(1);
      case 0:
        break;
      default:
				break;
    }
  }
}

int main(int argc, char **argv) {
	char *testname;
	struct programArgs args;
	getArguments(&args, argc, argv);
	size_t numThreads = args.threads;
	size_t iterations = args.iterations;
	size_t testID = args.testID;
	switch(testID) {
		case 0:
			testname = "add-none";
			break;
		case 1:
			testname = "add-yield";
			opt_yield = 1;
			break;
		default:
			testname = "add-none";
			break;
	}


	struct timespec start, finish;
	long long counter = 0;
	struct threadArgs inputs;
	inputs.counter = &counter;
	inputs.iterations = iterations;
	pthread_t threads[numThreads];
	clock_gettime(CLOCK_MONOTONIC, &start);
	for(size_t i = 0; i < numThreads; ++i) {
		int rc = pthread_create(&threads[i], NULL, addToCounter, &inputs);
		if(rc) {
			perror("Failed to create thread.\n");
			exit(1);
		}
	}
	for(size_t i = 0; i < numThreads; ++i) {
		int rc = pthread_join(threads[i], NULL);
		if(rc) {
			perror("Failed to join thread.\n");
			exit(1);
		}
	}
	clock_gettime(CLOCK_MONOTONIC, &finish);
	size_t time = 1000000000*(finish.tv_sec - start.tv_sec) + (finish.tv_nsec - start.tv_nsec);
	size_t operations = numThreads * iterations * 2;
	size_t aveTime = time/operations;
	fprintf(stdout, "%s,%lu,%lu,%lu,%lu,%lu,%lld\n", testname, numThreads, iterations, operations, time, aveTime, counter);

	return 0;
}
