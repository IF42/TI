CC=gcc
CFLAGS=-Wall -Wextra -pedantic -std=c2x -Ofast
LIBS=


INCLUDE_PATH=/usr/include/
LIB_PATH=/usr/lib64/

TARGET=libti.so
CACHE=.cache
OUTPUT=$(CACHE)/release

MODULES += moving_average.o
TEST += test.o


OBJ=$(addprefix $(CACHE)/,$(MODULES))
T_OBJ=$(addprefix $(CACHE)/,$(TEST))


all: env $(OBJ)	
	ar -crs $(OUTPUT)/$(TARGET) $(OBJ)


%.o:
	$(CC) $(CFLAGS) -c $< -o $@


-include dep.list


exec: all $(T_OBJ)
	$(CC) $(T_OBJ) $(OBJ) $(LIBS) -o $(OUTPUT)/test
	$(OUTPUT)/test


.PHONY: env dep clean


dep:
	$(CC) -MM test/*.c src/*.c | sed 's|[a-zA-Z0-9_-]*\.o|$(CACHE)/&|' > dep.list


env:
	mkdir -pv $(CACHE)
	mkdir -pv $(OUTPUT)


install:
	cp -v $(OUTPUT)/$(TARGET) $(LIB_PATH)/$(TARGET)
	mkdir -pv $(INCLUDE/PATH)/ti/
	cp -v src/*.h $(INCLUDE_PATH)/ti/


clean: 
	rm -vrf $(CACHE)



