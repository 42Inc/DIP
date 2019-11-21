CC = gcc
CFLAGS = -g3 -O0 -std=gnu99 -lm -msse

all: MAIN

MAIN: ./obj/main.o
	$(CC) ./obj/main.o -o ./bin/main $(CFLAGS)

./obj/main.o: ./src/main.c
	$(CC) -c ./src/main.c -o ./obj/main.o -std=c99

clean:
	rm ./obj/*.o
