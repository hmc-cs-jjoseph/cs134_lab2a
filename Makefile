GXX=gcc 
CSTD=-std=c99
FLAGS=-Wall -Wextra -Wpedantic
PTHREAD=-lpthread

lab2_add: lab2_add.c
	$(GXX) lab2_add.c -o lab2_add $(PTHREAD) $(CSTD) $(FLAGS)

clean:
	-rm lab2_add
	-rm lab2_add.csv
