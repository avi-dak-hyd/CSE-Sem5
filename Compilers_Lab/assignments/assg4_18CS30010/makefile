a.out: lex.yy.o y.tab.o ass4_18CS30010_main.o
	gcc lex.yy.o y.tab.o ass4_18CS30010_main.o -lfl

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

y.tab.o: y.tab.c
	gcc -c y.tab.c

ass4_18CS30010_main.o: ass4_18CS30010_main.c
	gcc -c ass4_18CS30010_main.c

lex.yy.c: ass4_18CS30010.l y.tab.h
	flex ass4_18CS30010.l

y.tab.c: ass4_18CS30010.y
	yacc -dtv ass4_18CS30010.y -W

y.tab.h: ass4_18CS30010.y
	yacc -dtv ass4_18CS30010.y -W

test: 
	./a.out < ass4_18CS30010_test.c

clean:
	rm lex.yy.c y.tab.c y.tab.h lex.yy.o y.tab.o ass4_18CS30010_main.o y.output a.out
