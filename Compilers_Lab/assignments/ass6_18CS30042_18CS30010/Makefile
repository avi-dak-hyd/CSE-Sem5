tinyc: y.tab.o lex.yy.o ass6_18CS30042_18CS30010_translator.o ass6_18CS30042_18CS30010_target_translator.o 
	g++ -g ass6_18CS30042_18CS30010_translator.o ass6_18CS30042_18CS30010_target_translator.o lex.yy.o y.tab.o -lfl -o tinyc
	
	# Generation of 3-Address Test Outputs and Assembly test Outputs

	# test_1
	./tinyc < ass6_18CS30042_18CS30010_test1.c > ass6_18CS30042_18CS30010_quad1.out
	mv output.s ass6_18CS30042_18CS30010_test1.s

	# test_2
	./tinyc < ass6_18CS30042_18CS30010_test2.c > ass6_18CS30042_18CS30010_quad2.out
	mv output.s ass6_18CS30042_18CS30010_test2.s

	# test_3
	./tinyc < ass6_18CS30042_18CS30010_test3.c > ass6_18CS30042_18CS30010_quad3.out
	mv output.s ass6_18CS30042_18CS30010_test3.s

	# test_4
	./tinyc < ass6_18CS30042_18CS30010_test4.c > ass6_18CS30042_18CS30010_quad4.out
	mv output.s ass6_18CS30042_18CS30010_test4.s

	# test_5
	./tinyc < ass6_18CS30042_18CS30010_test5.c > ass6_18CS30042_18CS30010_quad5.out
	mv output.s ass6_18CS30042_18CS30010_test5.s

	#test_6
	./tinyc < ass6_18CS30042_18CS30010_test6.c > ass6_18CS30042_18CS30010_quad6.out
	mv output.s ass6_18CS30042_18CS30010_test6.s

	# Run "make run" to execute all the object related files of test files at once
lex.yy.c: ass6_18CS30042_18CS30010.l
	flex ass6_18CS30042_18CS30010.l

y.tab.c: ass6_18CS30042_18CS30010.y
	yacc -dtv ass6_18CS30042_18CS30010.y

ass6_18CS30042_18CS30010_target_translator.o: ass6_18CS30042_18CS30010_target_translator.cxx
	g++ -g -c -no-pie ass6_18CS30042_18CS30010_target_translator.cxx

ass6_18CS30042_18CS30010_translator.o: ass6_18CS30042_18CS30010_translator.cxx
	g++ -g -c -no-pie ass6_18CS30042_18CS30010_translator.cxx

lex.yy.o: lex.yy.c
	g++ -g -c -no-pie lex.yy.c

y.tab.o:    y.tab.c
	g++ -g -no-pie -DYYDEBUG -c y.tab.c
	
libass2_18CS30042.a: ass2_18CS30042.o
	ar -rcs libass2_18CS30042.a ass2_18CS30042.o

ass2_18CS30042.o: ass2_18CS30042.c myl.h
	gcc -Wall  -c ass2_18CS30042.c -no-pie

ass2_18CS30042.c:
		touch ass2_18CS30042.c 

clean:
	rm -rf tinyc output test1 test2 test3 test4 test5 test6 lex.yy.c y.tab.h y.output y.tab.c lex.yy.o y.tab.o ass6_18CS30042_18CS30010_translator.o ass6_18CS30042_18CS30010_target_translator.o ass6_18CS30042_18CS30010_test1.o ass6_18CS30042_18CS30010_test2.o ass6_18CS30042_18CS30010_test3.o ass6_18CS30042_18CS30010_test4.o ass6_18CS30042_18CS30010_test5.o ass6_18CS30042_18CS30010_test6.o libass2_18CS30042.a ass2_18CS30042.o output.o ass6_18CS30042_18CS30010_quad1.out ass6_18CS30042_18CS30010_quad2.out ass6_18CS30042_18CS30010_quad3.out ass6_18CS30042_18CS30010_quad4.out ass6_18CS30042_18CS30010_quad5.out ass6_18CS30042_18CS30010_quad6.out ass6_18CS30042_18CS30010_test1.s ass6_18CS30042_18CS30010_test2.s ass6_18CS30042_18CS30010_test3.s ass6_18CS30042_18CS30010_test4.s ass6_18CS30042_18CS30010_test5.s ass6_18CS30042_18CS30010_test6.s

test1: ass6_18CS30042_18CS30010_test1.o libass2_18CS30042.a
	gcc -g -no-pie ass6_18CS30042_18CS30010_test1.o -o test1 -L. -lass2_18CS30042
ass6_18CS30042_18CS30010_test1.o: ass6_18CS30042_18CS30010_test1.s myl.h
	gcc -g -Wall  -c ass6_18CS30042_18CS30010_test1.s -no-pie -o ass6_18CS30042_18CS30010_test1.o

test2: ass6_18CS30042_18CS30010_test2.o libass2_18CS30042.a
	gcc -g  -no-pie ass6_18CS30042_18CS30010_test2.o -o test2 -L. -lass2_18CS30042
ass6_18CS30042_18CS30010_test2.o: ass6_18CS30042_18CS30010_test2.s myl.h
	gcc -g -Wall -c ass6_18CS30042_18CS30010_test2.s -no-pie

test3: ass6_18CS30042_18CS30010_test3.o libass2_18CS30042.a
	gcc -g  -no-pie ass6_18CS30042_18CS30010_test3.o -o test3 -L. -lass2_18CS30042
ass6_18CS30042_18CS30010_test3.o: ass6_18CS30042_18CS30010_test3.s myl.h
	gcc -g -Wall  -c ass6_18CS30042_18CS30010_test3.s -no-pie

test4: ass6_18CS30042_18CS30010_test4.o libass2_18CS30042.a
	gcc -g  -no-pie ass6_18CS30042_18CS30010_test4.o -o test4 -L. -lass2_18CS30042
ass6_18CS30042_18CS30010_test4.o: ass6_18CS30042_18CS30010_test4.s myl.h
	gcc -g -Wall  -c ass6_18CS30042_18CS30010_test4.s -no-pie

test5: ass6_18CS30042_18CS30010_test5.o libass2_18CS30042.a
	gcc -g  -no-pie ass6_18CS30042_18CS30010_test5.o -o test5 -L. -lass2_18CS30042
ass6_18CS30042_18CS30010_test5.o: ass6_18CS30042_18CS30010_test5.s myl.h
	gcc -g -Wall -c ass6_18CS30042_18CS30010_test5.s -no-pie

test6: ass6_18CS30042_18CS30010_test6.o libass2_18CS30042.a
	gcc -g  -no-pie ass6_18CS30042_18CS30010_test6.o -o test6 -L. -lass2_18CS30042
ass6_18CS30042_18CS30010_test6.o: ass6_18CS30042_18CS30010_test6.s myl.h
	gcc -g -Wall -c ass6_18CS30042_18CS30010_test6.s -no-pie

#output: output.o
output: output.o libass2_18CS30042.a
	gcc -g  -no-pie output.o -o output -L. -lass2_18CS30042
output.o: output.s myl.h
	gcc -g -Wall -c output.s -no-pie

run: 
	make test1
	make test2
	make test3
	make test4
	make test5
	make test6

