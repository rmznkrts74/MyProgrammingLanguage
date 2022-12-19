  %{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *str)
{
	fprintf(stderr, "error: %s\n", str);
	exit(0);
}

%}
%token INTEGER FLOAT CHARACTER
%token THINGS VAR DEFINE
%token OR AND 
%token B JBE S JSE JE JNE
%token MULT DIV PLS MNS
%token LBRACKET RBRACKET LCURLBRACKET RCURLBRACKET ENDLINE
%token QUIT START END MOM 
%token OUTPUT INPUT
%token WHITE DARK GREY
%token LOOPWHL DONE

%left OR
%left AND
%left B JBE S JSE JE JNE
%left PLS MNS
%left MULT DIV

%%
program:
    START declarations MOM statements END
    ;
declarations:
      declaration
    | declaration declarations
    ;
declaration:
      THINGS VAR ENDLINE
    ;
statements:
      statement
   	| statement statements
	;

statement:
      assignment
    | QUIT ENDLINE
    | OUTPUT expression ENDLINE
    | conditional
    | loopwhl
    ;

assignment://+
      VAR DEFINE expression ENDLINE
    | VAR DEFINE INPUT ENDLINE
    ;
expression:
      const
    | VAR
    | expression OR expression
    | expression AND expression
    | expression B expression
    | expression JBE expression
    | expression S expression
    | expression JSE expression
    | expression JE expression
    | expression JNE expression
    | expression PLS expression
    | expression MNS expression
    | expression MULT expression
    | expression DIV expression
    | LBRACKET expression RBRACKET
    ;

const://+
      INTEGER
    | FLOAT
    | CHARACTER
    ;
conditional:
     WHITE LBRACKET expression RBRACKET LCURLBRACKET
     statements
     RCURLBRACKET
     DONE
    | WHITE LBRACKET expression RBRACKET LCURLBRACKET
     statements
     RCURLBRACKET
     DARK  LCURLBRACKET
     statements
     RCURLBRACKET
     DONE
    | WHITE LBRACKET expression RBRACKET LCURLBRACKET
     statements
     RCURLBRACKET
     GREY LBRACKET expression RBRACKET LCURLBRACKET
     statements
     RCURLBRACKET
     DARK  LCURLBRACKET
     statements
     RCURLBRACKET
     DONE
     ;
loopwhl:
    LOOPWHL LBRACKET expression RBRACKET 
    LCURLBRACKET
    statements
    RCURLBRACKET
    DONE
    ;
%%


int main()
{
	yyparse();
	printf("OK!\n");
	return 0;
}
