# Project source code directory
DIR:= ./src
# Set flags, clean, etc. based on OS
# Windows
ifeq ($(OS),Windows_NT)
	CLEAN:= del build.exe test.exe
	INCLUDE:= -I($(DIR)) -I($(DIR)/headers) -I($(DIR)/cpptest/src/headers)
else
	UNAME_S:= $(shell uname -s)
# Linux
	ifeq ($(UNAME_S),Linux)
		CLEAN:= rm build test
		INCLUDE:= -I/$(DIR) -I/$(DIR)/headers -I/$(DIR)/cpptest/src/headers
	endif
endif

# Basic, universal flags
SRC:= $(wildcard $(DIR)/headers/*.h $(DIR)/*.h $(DIR)/*.c $(DIR)/*.cpp)
TESTS:= $(wildcard $(DIR)/tests/*.c $(DIR)/tests/*.cpp)
CPPTEST:= $(DIR)/cpptest/src/cpptest.cpp
CFLAGS:= -Wall $(INCLUDE)
BUILDFLAGS:= -DBUILD
TESTFLAGS:= -DTEST

all: $(SRC)
	make build
	make test

build: $(SRC)
	g++ -o $@ $^ $(CFLAGS) $(BUILDFLAGS)

test: $(SRC) $(TESTS) $(CPPTEST)
	g++ -o $@ $^ $(CFLAGS) $(TESTFLAGS)

fmt: $(SRC)
	clang-format -i $^

doc: $(SRC)
	doxygen ./.doxygen-format
	
clean:
	$(CLEAN)