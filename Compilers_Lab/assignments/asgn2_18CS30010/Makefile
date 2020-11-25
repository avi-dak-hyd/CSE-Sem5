a.out: main.o libass2_18CS30010.a
	g++ main.o -L. -lass2_18CS30010
main.o: main.c toylib.h
	g++ -Wall -c main.c
libass2_18CS30010.a: ass2_18CS30010.o
	ar -rcs libass2_18CS30010.a ass2_18CS30010.o
ass2_18CS30010.o: ass2_18CS30010.cpp toylib.h
	g++ -Wall -c ass2_18CS30010.cpp
clean:
	rm a.out main.o libass2_18CS30010.a ass2_18CS30010.o
