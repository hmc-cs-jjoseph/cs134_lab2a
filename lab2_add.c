#include <stdlib.h>
#include <pthread.h>
#include <stdio.h>
#include <getopt.h>
#include <time.h>

struct threadArgs{
	long long *counter;
	size_t iterations;
};

void add(long long *pointer, long long value) {
	long long sum = *pointer + value;
	*pointer = sum;
}

void *addToCounter(void *args) {
	struct threadArgs *argStruct = (struct threadArgs *) args;
	long long *counter = (long long *) (*argStruct).counter;
	size_t iterations = (size_t) (*argStruct).iterations;
	for(size_t i = 0; i < iterations; ++i) {
		add(counter, 1);
	}
	for(size_t i = 0; i < iterations; ++i) {
		add(counter, -1);
	}
	return (void *) args;
}

void getArguments(size_t *buff2, int argc, char **argv) {
	buff2[0] = 1;
	buff2[1] = 1;
	char opt;
	int optind;
  struct option options[] = {
    {"threads", required_argument, 0, 't'},
    {"iterations", required_argument, 0, 'i'},
    {0, 0, 0, 0}};
  while((opt = getopt_long(argc, argv, "t:i:", options, &optind)) != -1) {
    switch(opt) {
      case 't':
				buff2[0] = (size_t) atoi(optarg);
      	break;
			case 'i':
				buff2[1] = (size_t) atoi(optarg);
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
	char *testname = "add-none";
	size_t args[2];
	getArguments(args, argc, argv);
	size_t numThreads = args[0];
	size_t iterations = args[1];


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
