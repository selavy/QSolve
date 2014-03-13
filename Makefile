CC = gcc
CPP = g++
DEBUG = -g
NOTDEBUG = -fomit-frame-pointer #-Ofast
PYTHON_RECOMMENDED_FLAGS = `/usr/bin/python2.7-config --cflags`
CFLAGS = -pedantic -fPIC $(PYTHON_RECOMMENDED_FLAGS) $(NOTDEBUG) -Wno-long-long
PERMISSIVE = -fpermissive
INC = -I./include/ -I./database -I./portfolio/ -I./hash_table/ -I./queue/ -I./engine/
OBJS = main.o hash.o hash_table.o database.o queue.o engine.o portfolio.o
LD = -ldl
PYTHON_LNK = `/usr/bin/python2.7-config --ldflags`
#PYTHON = -I/usr/include/python2.7 -lpython2.7
PYTHON = $(PYTHON_LNK)
SHARED = -shared -Wl,-soname,
PRINT_STATUS = #-D_PRINT_
OBJS = main.o #database.o

qsolve: ./build/ $(OBJS)
	mv ./build/lib.linux-x86_64-2.7/* .
	ln -sf qsolve.so libqsolve.so
	$(CC) -o qsolve $(CFLAGS) $(INC) $(OBJS) $(LD) $(PYTHON) -L. -lqsolve
main.o: main.c
	$(CC) $(CFLAGS) $(INC) -c main.c $(LD) $(PYTHON)
database.o: ./database/database.h ./database/database.c
	$(CC) $(CFLAGS) $(INC) -c ./database/database.c $(PYTHON) 
./build/: qsolvemodule.c
	python qsolvesetup.py build
.PHONY: clean
clean:
	rm -rf *.o *.so qsolve build/ *.pyc
