CC = mpicc
CFLAGS = -Wall
LIB = -lm
INCLUDES = -I src/
dirs = ./bin ./obj
rdsync_obj = ./obj/rdsync.o

all: ./bin/rdsync

./bin/rdsync: $(dirs) $(rdsync_obj)
	$(CC) $(rdsync_obj) $(CFLAGS) -o ./bin/cmpl $(LIB)

$(dirs):
	mkdir obj
	mkdir bin

./obj/rdsync.o: ./src/rdsync.c
	$(CC) -c $(CFLAGS) ./src/rdsync.c -o ./obj/rdsync.o $(INCLUDES)

.PHONY: clean exec
clean:
	rm -r -f bin/
	rm -r -f obj/

exec:
	make
	./bin/cmpl

rebuild:
	make clean ; make