#SOURCE=src/
#BUILD=build/
#LIB=lib/
#INCLUDE=include/

# (Windows) Modify SFML_PATH if you have a different installation location.
SFML_PATH="C:/SFML-2.6.2/"
SFML_INCLUDE=$(SFML_PATH)include/
SFML_LIB=$(SFML_PATH)lib/

CXX=g++
OFLAGS=-g -O2 -std=c++17 -Wall -Werror -Wpedantic -Wextra -MMD
CXXFLAGS=$(OFLAGS) -I$(SFML_INCLUDE) -fPIC
LDFLAGS=-lsfml-audio -lsfml-system -lpthread -L$(SFML_LIB)

ifeq ($(OS),Windows_NT)
	LIB_NAME=SSEQPlayer.dll
else
	LIB_NAME=libSSEQPlayer.so
endif

# build all objs by implicit rule
OBJECTS=binhelper.o SWAV.o SWAR.o SBNK.o SSEQ.o SSEQStream.o main.o

objs = ${OBJECTS}
#objs=$(OBJECTS:%=$(BUILD)%)

exec: $(OBJECTS)
	$(CXX) $(OBJECTS) $(LDFLAGS) -o SSEQTest

lib: $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(OBJECTS) -shared -o ${LIB_NAME} $(LDFLAGS)

all: lib exec

clean:
	rm -f SSEQTest
	rm -f ${LIB_NAME}
	rm -f *.o

-include $(objs:%.o=%.d)
