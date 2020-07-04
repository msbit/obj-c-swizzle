run: main libswizzle.dylib
	./main
	DYLD_INSERT_LIBRARIES=libswizzle.dylib ./main
	./main libswizzle.dylib
	DYLD_INSERT_LIBRARIES=libswizzle.dylib ./main libswizzle.dylib

libswizzle.dylib:
	$(CC) -dynamiclib -fmodules swizzle.m -o libswizzle.dylib

main:
	$(CC) -fmodules main.m -o main

clean:
	rm -f libswizzle.dylib main
