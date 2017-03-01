GXX=gcc 
FLAGS=-Wall -Wextra -Wpedantic
PTHREAD=-lpthread
LISTSOURCES=SortedList.h SortedList.c SortedList_m.c SortedList_m.h SortedList_s.c SortedList_s.h
MODULES=lab2_add.c lab2_list.c
DATA=lab2_add.csv lab2_list.csv
IMAGES=lab2_add-1.png lab2_add-2.png lab2_add-3.png lab2_add-4.png lab2_add-5.png lab2_list-1.png lab2_list-2.png lab2_list-3.png lab2_list-4.png

lab2_list: lab2_list.c SortedList.c SortedList_m.c SortedList_s.c
	make SortedList
	make SortedList_m
	make SortedList_s
	$(GXX) lab2_list.c -o lab2_list $(PTHREAD) $(FLAGS) SortedList.o SortedList_s.o SortedList_m.c

lab2_add: lab2_add.c
	$(GXX) lab2_add.c -o lab2_add $(PTHREAD) $(CSTD) $(FLAGS)

SortedList: SortedList.h SortedList.c
	$(GXX) -c SortedList.c  $(PTHREAD) $(FLAGS)

SortedList_s: SortedList_s.h SortedList_s.c
	$(GXX) -c SortedList_s.c  $(PTHREAD) $(FLAGS)

SortedList_m: SortedList_m.h SortedList_m.c
	$(GXX) -c SortedList_m.c  $(PTHREAD) $(FLAGS)

dist:
	tar -czvf lab2a-040161840.tar.gz Makefile README $(LISTSOURCES) $(MODULES) $(DATA) $(IMAGES)

clean:
	-rm lab2_add
	-rm lab2_list
	-rm SortedList.o
	-rm SortedList_m.o
	-rm SortedList_s.o
