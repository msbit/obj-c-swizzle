CFLAGS=-fmodules

lib%.dylib: %.m
	$(CC) -dynamiclib $(CFLAGS) $(<) -o $(@)

all: main libswizzle.dylib
	./main
	DYLD_INSERT_LIBRARIES=libswizzle.dylib ./main
	./main libswizzle.dylib
	DYLD_INSERT_LIBRARIES=libswizzle.dylib ./main libswizzle.dylib

clean:
	rm -f libswizzle.dylib main
