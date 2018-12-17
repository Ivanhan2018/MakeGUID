SRC=Libary.cpp \
	items.cpp\
	Manager.cpp\
	Mysql_select.cpp\
	Reader.cpp\
	ways.cpp

CC=gcc
CXX=g++

INC=-I. -I../include
INC_MYSQL=`mysql_config --include` -I../mysql/include/
INC_REDIS=-I../hiredis/

LIB=-L. -L../lib
LIB_MYSQL=`mysql_config --libs_r` 
LIB_REDIS=-L../hiredis/ -lhiredis
LIB_MEMCACHED=-lmemcached -lpthread
FLAG= -Wall -g 

all:Libarydb

Libarydb:$(SRC:.cpp=.o)
	$(CXX) -o $@ $^  $(LIB) $(LIB_MYSQL) $(FLAG) 

%.o:%c
	$(CC) -o $@ -c  $< $(INC) $(INC_MYSQL) $(FLAG)

%.o:%.cpp
	$(CXX) -o $@ -c  $< $(INC) $(INC_MYSQL) $(FLAG)

clean:
	rm -rf *.o Libarydb

