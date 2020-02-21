prog := wordcount
prog_objs := wordcount.o

CXX := g++
CXXFLAGS := -g -Wall -std=c++11 -O2 -I/opt/hadoop/include
LDFLAGS := -L/opt/hadoop/lib/native -lcrypto -lssl -lhadooppipes -lhadooputils -lpthread

.PHONY: all clean

all: $(prog)

$(prog): $(prog_objs)
	$(CXX) -o $@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

wordcount.o: wordcount.cpp

clean:
	@rm -rf *.o $(prog)
