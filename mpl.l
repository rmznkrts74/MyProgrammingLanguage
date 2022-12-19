%{ /* definitions */
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
%}

%% /* rules */
INT|FLOAT|CHAR              return THINGS;

[a-z_][a-z0-9_]*            return VAR;
":"                         return DEFINE;
"/"                         return OR;
"&"                         return AND;
">"                         return B;
">="                        return JBE;
"<"                         return S;
"<="                        return JSE;
"="                         return JE;
"!!"                       return JNE;
"\*"                        return MULT;
"\\"                        return DIV;
"\+"                        return PLS;
"\-"                        return MNS;
"("                         return LBRACKET;
")"                         return RBRACKET;
"{"                         return LCURLBRACKET;
"}"                         return RCURLBRACKET;
[+-]?[0-9]+                 yylval = atoi(yytext); return INTEGER;
[+-]?[0-9]+\.[0-9]+         yylval = atof(yytext); return FLOAT;
\'.\'                       return CHARACTER;
"!"                         return ENDLINE;

QUIT                        return QUIT;
BEGIN                       return START;
MOM                         return MOM;
END                         return END;
INP                         return INPUT;
OUTP                        return OUTPUT;
WHITE                       return WHITE;
DARK                        return DARK;
GREY                        return GREY;
LOOPWHL                     return LOOPWHL;
DONE                        return DONE;

\n                          /* ignore end of line */;
[ \t]+                      /* ignore whitespace */;

%%

int yywrap()
{
	return 1;
}


