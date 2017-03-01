GXX=gcc 
FLAGS=-Wall -Wextra -Wpedantic
PTHREAD=-lpthread
LISTSOURCES=SortedList.h SortedList.c SortedList_m.c SortedList_m.h SortedList_s.c SortedList_s.h
MODULES=lab2_add.c lab2_list.c
DATA=lab2_add.csv lab2_list.csv
IMAGES=lab2_add-1.png lab2_add-2.png lab2_add-3.png lab2_add-4.png lab2_add-5.png lab2_list-1.png lab2_list-2.png lab2_list-3.png lab2_list-4.png
TESTS=add_test.sh list_test.sh

all: lab2_list.c lab2_add.c SortedList.c SortedList_m.c SortedList_s.c
	make lab2_add
	make lab2_list

lab2_add: lab2_add.c
	$(GXX) lab2_add.c -o lab2_add $(PTHREAD) $(FLAGS)

lab2_list: lab2_list.c SortedList.c SortedList_m.c SortedList_s.c
	make SortedList
	make SortedList_m
	make SortedList_s
	$(GXX) lab2_list.c -o lab2_list $(PTHREAD) $(FLAGS) SortedList.o SortedList_s.o SortedList_m.o

SortedList: SortedList.h SortedList.c
	$(GXX) -c SortedList.c  $(PTHREAD) $(FLAGS)

SortedList_s: SortedList_s.h SortedList_s.c
	$(GXX) -c SortedList_s.c  $(PTHREAD) $(FLAGS)

SortedList_m: SortedList_m.h SortedList_m.c
	$(GXX) -c SortedList_m.c  $(PTHREAD) $(FLAGS)

graphs:
	gnuplot lab2_list.gp
	gnuplot lab2_add.gp

tests:
	make all
	bash add_test.sh
	bash list_test.sh

dist:
	tar -czvf lab2a-040161840.tar.gz Makefile README $(LISTSOURCES) $(MODULES) $(DATA) $(IMAGES) $(TESTS)

clean:
	-rm lab2_add
	-rm lab2_list
	-rm SortedList.o
	-rm SortedList_m.o
	-rm SortedList_s.o
