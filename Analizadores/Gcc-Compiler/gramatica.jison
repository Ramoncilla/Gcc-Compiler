/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'decimal'
[0-9]+	              return 'entero'
"'"([0-9]|[a-zA-Z])"'" return 'caracter'
"true"		      return 'booleano'
"false"               return 'booleano' 	       
"*"                   return 'por'
"/"                   return 'division'
"-"                   return 'menos'
"+"                   return 'mas'
"^"                   return 'potencia'
"("                   return 'abrePar'
")"                   return 'cierraPar'
"||"                   return 'or'
"&&"                   return 'and'
"??"                   return 'xor'
"!"                   return 'not'

"<"                   return 'menor'
">"                   return 'mayor'
"<="                   return 'menorIgual'
">="                   return 'mayorIgual'
"=="                   return 'igualIgual'
"!="                   return 'distintoA'

<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left mas menos
%left por  division
%left potencia


%start INICIO

%% /* language grammar */


INICIO: SIMB_ARIT EOF{return $1;};


TIPO_VARIABLE: entero{$$ = new Entero($1);}
	|decimal{$$ = new Decimal($1);}
	|caracter
	|booleano;

SIMB_ARIT: mas{$$ =$1;}
	|menos{$$ = $1;}
	|por{$$ = $1;}
	|division{$$ = $1;}
	|potencia{$$ = $1;};

SIMB_LOG: and{$$ =$1;}
	|or{$$ =$1;}
	|xor{$$ =$1;};

SIMB_REL: menor{$$ =$1;}
	|mayor{$$ =$1;}
	|menorIgual{$$ =$1;}
	|mayorIgual{$$ =$1;}
	|igualIgual{$$ =$1;}
	|igualIgual{$$ =$1;}
	|distintoA{$$ =$1;};








	
	