%%
[ \t]  ;
printf return PRINT;
while return WHILE;
\- return SUB;
\* return MUL;
\/ return DIV;
\n ;
\" return QUOTE;
"%d"|"%c"|"%ld" return PER;
= return EQ;
[<>] return ROP;
[a-zA-Z]+("++"|"--") return INC;
"(" return OPEN;
\+ return ADD;
")" return CLOSE;
1 return ONE;
[0-9]+ {yylval = yytext[0];return NUMBER;}
[a-zA-Z]+ {yylval = yytext[0];return ID;}
. {return yytext[0];}
%%
