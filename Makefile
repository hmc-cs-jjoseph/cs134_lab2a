GXX=gcc
FLAGS=-Wall -Wextra -Wpedantic
PTHREAD=-lpthread

lab2_add: lab2_add.c lab2_add.h
	$(GXX) lab2_add.c -o lab2_add $(PTHREAD) $(FLAGS)

clean:
	-rm lab2_add
