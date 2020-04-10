%{
#include<stdio.h>
#include<stdlib.h>

char temp_store ='A';
int no_of_addr=0;
int count=0;
char addtotable(char,char,char);
void addr_code();
void opt();
struct node{
char operand1;
char operand2;
char operator;
char result;
};

%}

%right ROP
%left ADD SUB
%left MUL DIV
%left OPEN CLOSE
%right EQ

%token NUMBER ONE ID WHILE INC ROP OPEN  CLOSE ADD SUB MUL DIV EQ PER QUOTE PRINT

%%
start : wh | st ;
st  : ID EQ exp ';' {addtotable($1,$3,'='); 
 	printf("Before Optimization\n");   
	addr_code();
    	opt();
	printf("After Optimization\n");
    	addr_code();
    };
exp : exp ADD exp {$$ = addtotable($1,$3,'+');temp_store++;}
    | exp SUB exp {$$ = addtotable($1,$3,'-');temp_store++;}
    | exp MUL exp {$$ = addtotable($1,$3,'*');temp_store++;}
    | exp DIV exp {$$ = addtotable($1,$3,'/');temp_store++;}
    | OPEN exp CLOSE {$$ = $2;}
    | NUMBER {$$ = $1;}
    | ID {$$=$1;};
wh  : WHILE OPEN con CLOSE '{' STMT '}' {printf("Infinite loop detected\n");}
STMT: ID ID';'STMT /*ID A ';' STMT*/
    | exp1 ';' STMT
    | pri';'STMT
    | ;
pri : PRINT OPEN PR CLOSE  {if(count!=0){printf("Invalid printf\n");return 0;}};
PR  : QUOTE P QUOTE Q ;
Q   : ','ID Q {count--;if(count<0){printf("Invalid printf\n");return 0;}}
    | ID | ;
P   : ID P 
    | PER P {count++;}
    | ;  
/*A   : ID  A
    | ;*/
exp1: exp1 ADD exp1
    | exp1 SUB exp1
    | exp1 MUL exp1
    | exp1 DIV exp1
    | ID
    | NUMBER
    | OPEN exp1 CLOSE
con : ID ro NUMBER
    | ID ro ID
    |ONE;
ro : ROP EQ|ROP;
%%

struct node addr[20];

char addtotable(char a, char b, char c){
    addr[no_of_addr].operand1=a;
    addr[no_of_addr].operand2=b;
    addr[no_of_addr].operator=c;
    addr[no_of_addr].result=temp_store;
    no_of_addr++;
    return temp_store;
}

void addr_code(){
    int i;
    for(i=0;i<no_of_addr;i++){
        if(addr[i].operator=='!') continue;
        printf("%c =\t",addr[i].result);
        printf("%c\t",addr[i].operand1);
        printf("%c\t",addr[i].operand2);
        printf("%c\n",addr[i].operator);
    }
}

void opt(){
 int i,j;
 for(i=0;i<no_of_addr;i++)
  for(int j=i+1;j<no_of_addr;j++){
   if(addr[i].operator==addr[j].operator && addr[i].operand1 ==addr[j].operand1 && addr[i].operand2 == addr[j].operand2){
    int z;
    for(int z=j+1;z<no_of_addr;z++){
    if(addr[z].operand1==addr[j].result) addr[z].operand1=addr[i].result;
    if(addr[z].operand2==addr[j].result) addr[z].operand2=addr[i].result;
    }
    addr[j].operator='!';
   }
  }
}

#include"lex.yy.c"

int main(){
    printf("Enter the assignment expression ends with semicolon... OR \nAn infinite while loop...\n");
    yyparse();
    return 0;
}
