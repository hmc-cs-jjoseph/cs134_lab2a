/* \file lab2_add.h
 * \detail provides function declarations for lab2_add.c
 * \author Jesse Joseph
 * \ID 040161840
 * \email jjoseph@hmc.edu
 */

#include <pthread.h>
#include <time.h>

void add(long long *pointer, long long value);

int main(int argc, char **argv);

void *addToCounter(void *args);
