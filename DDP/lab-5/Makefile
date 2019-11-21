CC = gcc
CFLAGS = -g3 -O0  -msse -mavx2 -lm

all: MAIN

MAIN: ./obj/main.o ./obj/main_saxpy.o
	$(CC) ./obj/main.o -o ./bin/main $(CFLAGS)
	$(CC) ./obj/main_saxpy.o -o ./bin/saxpy $(CFLAGS)

./obj/main.o: ./src/main.c
	$(CC) -c ./src/main.c -o ./obj/main.o $(CFLAGS)

./obj/main_saxpy.o: ./src/main_saxpy.c
	$(CC) -c ./src/main_saxpy.c -o ./obj/main_saxpy.o $(CFLAGS)


clean:
	rm ./obj/*.o
