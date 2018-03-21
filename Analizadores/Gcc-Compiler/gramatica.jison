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


TIPO_VARIABLE: entero
	|decimal
	|caracter
	|booleano;

SIMB_ARIT: mas{$$ =$1;}
	|menos{$$ = $1;}
	|por{$$ = "*";}
	|division{$$ = "/";}
	|potencia{$$ = "^";};


	
	
