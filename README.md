TOOLS USED:
  1. lex – in order to find the tokens and lexemes
  2. yacc – for parsing and 3 address code generation
	
IMPLEMENTATION DETAILS:    
	We have implemented the program in Ubuntu Terminal. 
    For that, u must have flex and bison in it. 
    It can be installed by the following command.
    
1.	sudo apt-get update
2.	sudo apt-get install flex
3.	sudo apt-get install bison

Note : Make sure you must install C libraries in terminal.

Then paste the lex file(filename.l) and yacc file(filename.y) in the same directory.
Run the code using following commands,

1.	lex filename.l
2.	yacc filename.y
3.	gcc y.tab.c –ll –ly
4.	./a.out
