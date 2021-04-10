LDFLAGS=-fobjc-link-runtime

lib%.dylib: %.m
	$(CC) -dynamiclib $(CFLAGS) $(LDFLAGS) $(<) -o $(@)

all: main libswizzle.dylib
	./main
	DYLD_INSERT_LIBRARIES=libswizzle.dylib ./main
	./main libswizzle.dylib
	DYLD_INSERT_LIBRARIES=libswizzle.dylib ./main libswizzle.dylib

main: main.o BIBuildInformation.o

clean:
	rm -f libswizzle.dylib main *.o
