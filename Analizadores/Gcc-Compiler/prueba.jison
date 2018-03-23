%{
	var Nodo = require("../Simbolos/Nodo");
%}

/* lexical grammar */
%lex
letra [a-zA-Z]
id [a-zA-Z_][a-zA-Z0-9_]*
numero [0-9]+("."[0-9]+)?\b

%%


\s+                    /* skip whitespace */
[%%].* 				  /* skip whitespace */
"¿".*"?" 			 /* skip whitespace */

/* RESERVADAS */
"if"                 return 'if';
"then"               return 'then';
"else"               return 'else';
"switch"             return 'switch';
"case"               return 'case';
"default"            return 'default';
"break"              return 'break';
"continue"           return 'continue';
"return"             return 'return';
"while"              return 'while';
"do"                 return 'do';
"repeat"             return 'repeat';
"until"              return 'until';
"for"                return 'for';
"loop"               return 'loop';
"count"              return 'count';
"whilex"             return 'whilex';
"array"              return 'array';
"of"                 return 'of';
"create"             return 'create';
"element"            return 'element';
"NULL"            	 return 'nulo';
"Principal"          return 'principal';
"inNum"              return 'inNum';
"outStr"             return 'outStr';
"outNum"             return 'outNum';
"inStr"              return 'inStr';
"show"             	 return 'show';
"getRandom"          return 'getRandom';

/* TIPO */
"bool"                 	return 'bool';
"num"                	return 'num';
"str"                	return 'str';
"true"                 	return 'tTrue';
"false"                 return 'tFalse';
"void"                	return 'void';

/* ARITMETICOS */
"*"                   return '*';
"/"                   return '/';
"-"                   return '-';
"+"                   return '+';
"^"                   return '^';
"%"                   return '%';

/* RELACIONALES */
"=="                   return '==';
"!="                   return '!=';
"<="                   return '<=';
">="                   return '>=';
"<"                   return '<';
">"                   return '>';

/* LOGICOS */
"||"                   return '||';
"|?"                   return '|?';
"&&"                   return '&&';
"&?"                   return '&?';
"|&"                   return '|?';
"!"                    return '!';

/* SIMBOLOS */
"("                   return '(';
")"                   return ')';
"{"                   return '{';
"}"                   return '}';
"["                   return '[';
"]"                   return ']';
";"                   return ';';
":"                   return ':';
"="                   return '=';
","                   return ',';
"."                   return '.';

{numero}  				return 'tNumero';
{id}					return 'tId';
\"(\\.|[^"])*\"			return 'tCadena';
"'"(\\.|[^"'"])"'" 		return 'tCaracter';
<<EOF>>               	return 'EOF';

/lex

%start INICIO

%% /* language grammar */

INICIO : SENTENCIAS EOF
		{
			console.log("terminado");
			return $1;
		};

TIPO: tId
	{
		$$ = $1;
	}
	| bool
	{
		$$ = $1;
	}
	| num
	{
		$$ = $1;
	}
	| str
	{
		$$ = $1;
	}
	| void
	{
		$$ = $1;
	};
	
SENTENCIAS: SENTENCIAS SENTENCIA
			{
				$$ = $1;
				$$.agregar($2);
			}
			| SENTENCIA
			{
				$$ = $1;
			};
	
SENTENCIA: PRINCIPAL
		{
			$$ = $1;
		}
		| DECFUNCION
		{
			$$ = $1;
		}
		| DECESTRUCTURA
		{
			$$ = $1;
		}
		| DECVARIABLE ';'
		{
			$$ = $1;
		}
		| DECARREGLO ';'
		{
			$$ = $1;
		};
		
PRINCIPAL: principal '(' ')' '{' INSTRUCCIONES '}'
		{
			$$ = new Nodo("principal", "principal", "principal");
			$$.hijos[1] = $5;
		};
	
DECFUNCION: TIPO_FUNCION ':' tId '(' DECPARAMETROS ')' '{' INSTRUCCIONES '}'
		{
			$$ = new Nodo($3, $1, "dec_funcion");
			$$.hijos[0] = $5;
			$$.hijos[1] = $8;
		};

DECPARAMETROS: DECPARAMETROS ',' TIPO tId
			{
				$$ = $1;
				var temp = new Nodo($4, $3, "parametro");
				$$.agregar(temp);
			}
			| DECPARAMETROS ',' TIPO '*' tId
			{
				$$ = $1;
				var temp = new Nodo($5, $3, "par_referencia");
				$$.agregar(temp);
			}
			| DECPARAMETROS ',' TIPO tId DECDIMENSIONES
			{
				$$ = $1;
				var temp = new Nodo($4, $3, "par_arreglo");
				$$.hijos[0] = $5;
				$$.agregar(temp);
			}
			| TIPO tId
			{
				$$ = new Nodo($2, $1, "parametro");
			}
			| TIPO '*' tId
			{
				$$ = new Nodo($3, $1, "par_referencia");
			}
			| TIPO tId DECDIMENSIONES
			{
				$$ = new Nodo($2, $1, "par_arreglo");
				$$.hijos[0] = $3;
			}
			|
			{
				$$ = null;
			};
		
TIPO_FUNCION: TIPO
			{
				$$ = $1;
			}
			| TIPO TIPOARR
			{
				$$ = $1 + "_" + $2;
			};
			
TIPOARR: TIPOARR '[' ']'
		{
			$$ = $1 + 1;
		}
		| '[' ']'
		{
			$$ = 1;
		};

DECESTRUCTURA: element ':' tId '{' CUERPOESTRUCTURA '}'
			{
				$$ = new Nodo($3, $3, "dec_estructura");
				$$.hijos[0] = $5;
			};

CUERPOESTRUCTURA: CUERPOESTRUCTURA ESTRUCTURA
				{
					$$ = $1;
					$$.agregar($2);
				}
				| ESTRUCTURA
				{
					$$ = $1;
				};
				
ESTRUCTURA: DECESTRUCTURA
		{
			$$ = $1;
		}
		| TIPO tId ':' LOG ';'
		{
			$$ = new Nodo($2, $1, "dec_atributo");
			$$.hijos[0] = $4;
		};
	
DECARREGLO: 'array' ':' tId DECDIMENSIONES 'of' TIPO
			{
				$$ = new Nodo($3, $6, "dec_arreglo");
				$$.hijos[0] = $4;
			};

DECDIMENSIONES: DECDIMENSIONES '[' tNumero ']'
				{
					$$ = $1;
					temp = new Nodo("dimension", "dimension", "dimension");
					$$.hijos[0] = 0;
					$$.hijos[1] = $3;
					$$.agregar(temp);
				}
				| DECDIMENSIONES '[' tNumero '.' '.' tNumero ']'
				{
					$$ = $1;
					temp = new Nodo("dimension", "dimension", "dimension");
					$$.hijos[0] = $3;
					$$.hijos[1] = $6;
					$$.agregar(temp);
				}
				| '[' tNumero ']'
				{
					$$ = new Nodo("dimension", "dimension", "dimension");
					$$.hijos[0] = 0;
					$$.hijos[1] = $2;
				}
				| '[' tNumero '.' '.' tNumero ']'
				{
					$$ = new Nodo("dimension", "dimension", "dimension");
					$$.hijos[0] = $2;
					$$.hijos[1] = $5;
				};
	
DECVARIABLE: TIPO tId TIPODECVARIABLE
			{
				$$ = $3;
				$$.tipo = $1;
				$$.nombre = $2;
			};

TIPODECVARIABLE: ':' TIPODECVARIABLE__
				{
					$$ = $2;
				}
				| ',' LID TIPODECVARIABLE_
				{
					$$ = new Nodo($2, "dec_variables", "dec_variables");
					$$.operacion = $2;
					$$.hijos[0] = $3;
				}
				| 
				{
					$$ = new Nodo("dec_variable", "dec_variable", "dec_variable");
					$$.operacion = "-1";
				};
				
TIPODECVARIABLE__: LOG
				{
					$$ = new Nodo("dec_variable", "dec_variable", "dec_variable");
					$$.operacion = "-1";
					$$.hijos[0] = $1;
				}
				| create '(' tId ')'
				{
					$$ = new Nodo("dec_objeto", $3, "dec_objeto");
				};
				
TIPODECVARIABLE_: ':' LOG
				{
					$$ = $2;
				}
				| 
				{
					$$ = null;
				};
				
LID: LID ',' tId
	{
		$$ = $1 + "," + $3;
	}
	| tId
	{
		$$ = $1;
	};

ASIGVARIABLE: tId ASIGVARIABLE_
			{
				$$ = $2;
				$$.nombre = $1;
			}
			| ACCESO ASIGACCESO
			{
				$$ = new Nodo("asig_acceso", "asig_acceso", "asig_acceso");
				$$.hijos[0] = $1;
				$$.hijos[1] = $2;
			};

ASIGVARIABLE_: '=' ASIGVARIABLE__
			{
				$$ = $2;
			}
			| DIMENSIONES '=' LOG
			{
				$$ = new Nodo("asig_arreglo", "asig_arreglo", "asig_arreglo");
				$$.hijos[0] = $1;
				$$.hijos[1] = $3;
			}
			| '(' PARAMETROS ')'
			{
				$$ = new Nodo("funcion", "funcion", "funcion");
				$$.hijos[0] = $2;
			};
			
ASIGVARIABLE__:  LOG
			{
				$$ = new Nodo("asig_variable", "asig_variable", "asig_variable");
				$$.hijos[0] = $1;
			}
			| create '(' tId ')'
			{
				$$ = new Nodo("asig_objeto", $3, "asig_objeto");
			}
			;
			
ASIGACCESO: '=' LOG
			{
				$$ = new Nodo("asig_variable", "asig_variable", "asig_variable");
				$$.hijos[0] = $2;
			}
			| '=' create '(' tId ')'
			{
				$$ = new Nodo("asig_objeto", $4, "asig_objeto");
			};

SENTENCIACONTROL: while '(' LOG ')' '{' INSTRUCCIONES '}'
				{
					$$ = new Nodo("while", "sentencia_while", "sentencia_control");
					$$.hijos[0] = $3;
					$$.hijos[1] = $6;
				}
				| do '{' INSTRUCCIONES '}' while '(' LOG ')'
				{
					$$ = new Nodo("do", "sentencia_do", "sentencia_control");
					$$.hijos[0] = $3;
					$$.hijos[1] = $7;
				}
				| repeat '{' INSTRUCCIONES '}' until '(' LOG ')'
				{
					$$ = new Nodo("repeat", "sentencia_repeat", "sentencia_control");
					$$.hijos[0] = $3;
					$$.hijos[1] = $7;
				}
				| for '(' DECVARIABLE ';' LOG ';' ASIGVARIABLE ')' '{' INSTRUCCIONES '}'
				{
					$$ = new Nodo("for", "sentencia_for", "sentencia_control");
					$$.hijos[0] = $3;
					$$.hijos[1] = $5;
					$$.hijos[2] = $7;
					$$.hijos[3] = $10;
				}
				| loop tId '{' INSTRUCCIONES '}'
				{
					$$ = new Nodo("loop", "sentencia_loop", "sentencia_control");
					$$.hijos[0] = $2;
					$$.hijos[1] = $4;
				}
				| count '(' LOG ')' '{' INSTRUCCIONES '}'
				{
					$$ = new Nodo("count", "sentencia_count", "sentencia_control");
					$$.hijos[0] = $3;
					$$.hijos[1] = $6;
				}
				| do '{' INSTRUCCIONES '}' whilex '(' LOG ',' LOG')'
				{
					$$ = new Nodo("whilex", "sentencia_whilex", "sentencia_control");
					$$.hijos[0] = $3;
					$$.hijos[1] = $7;
					$$.hijos[2] = $9;
				};

SENTENCIAFLUJO: if '(' LOG ')' then '{' INSTRUCCIONES '}'
			{
				$$ = new Nodo("if", "sentencia_if", "sentencia_control");
				$$.hijos[0] = $3;
				$$.hijos[1] = $7;
			}
			| if '(' LOG ')' then '{' INSTRUCCIONES '}' 'else' '{' INSTRUCCIONES '}'
			{
				$$ = new Nodo("if_else", "sentencia_if_else", "sentencia_control");
				$$.hijos[0] = $3;
				$$.hijos[1] = $7;
				$$.hijos[2] = $11;
			}
			| switch '(' LOG ',' LOG ')' '{' LCASE default ':' INSTRUCCIONES '}'
			{
				$$ = new Nodo("switch", "sentencia_switch", "sentencia_control");
				$$.hijos[0] = $3;
				$$.hijos[1] = $5;
				$$.hijos[2] = $8;
				$$.hijos[3] = $11;
			};
	
LCASE: LCASE case CASEVAL ':'
	{
		$$ = $1;
		$$.agregar($3);
	}
	| case CASEVAL ':'
	{
		$$ = $2;
	};
	
CASEVAL: tNumero
		{
			$$ = new Nodo($1, "valor", "valor");
		}
		| tCadena
		{
			$$ = new Nodo($1, "valor", "valor");
		}
		| tNumero '-' tNumero
		{
			$$ = new Nodo($1, $3, "rango");
		}
		| tCaracter '-' tCaracter
		{
			$$ = new Nodo($1, $3, "rango");
		};

INSTRUCCIONES: INSTRUCCIONES INSTRUCCION
			{
				$$ = $1;
				$$.agregar($2);
			}
			| INSTRUCCION
			{
				$$ = $1;
			};
			
INSTRUCCION: break ';'
			{
				$$ = new Nodo("break", "break", "break");
				$$.operacion = "no_id";
			}
			| break tId ';'
			{
				$$ = new Nodo("break	", "break", "break");
				$$.operacion = $2;
			}
			| continue ';'
			{
				$$ = new Nodo("continue", "continue", "continue");
			}
			| return LOG ';'
			{
				$$ = new Nodo("return", "return", "return");
				$$.hijos[0] = $2;
			}
			| return ';'
			{
				$$ = new Nodo("return", "return", "return");
			}
			| SENTENCIACONTROL
			{
				$$ = $1;
			}
			| SENTENCIAFLUJO
			{
				$$ = $1;
			}
			| ASIGVARIABLE ';'
			{
				$$ = $1;
			}
			| DECVARIABLE ';'
			{
				$$ = $1;
			}
			| DECARREGLO ';'
			{
				$$ = $1;
			}
			| ESPECIALES ';'
			{
				$$ = $1;
			};
			
ESPECIALES: outStr '(' LOG ')'
		{
			$$ = new Nodo("outStr", "outStr", "especial");
			$$.hijos[0] = $3;
		}
		| outNum '(' LOG ',' LOG ')'
		{
			$$ = new Nodo("outNum", "outNum", "especial");
			$$.hijos[0] = $3;
			$$.hijos[1] = $5;
		}
		| show '(' LOG ')'
		{
			$$ = new Nodo("show", "show", "especial");
			$$.hijos[0] = $3;
		}
		| inNum '(' LOG ',' LOG ')'
		{
			$$ = new Nodo("inNum", "inNum", "especial");
			$$.hijos[0] = $3;
			$$.hijos[1] = $5;
		}
		| inStr '(' tId ',' LOG ')'
		{
			$$ = new Nodo("inStr", "inStr", "especial");
			$$.hijos[0] = $3;
			$$.hijos[1] = $5;
		}
		
		| getRandom '('  ')'
		{
			$$ = new Nodo("getRandom", "getRandom", "especial");
		};
		
LOG: LOG '||' AND
	{
		$$ = new Nodo("logico", "logico", "logico");
		$$.operacion = $2;
		$$.hijos[0] = $1;
		$$.hijos[1] = $3;
	}
	| LOG '|?' AND
	{
		$$ = new Nodo("logico", "logico", "logico");
		$$.operacion = $2;
		$$.hijos[0] = $1;
		$$.hijos[1] = $3;
	}
	| AND
	{
	 $$ = $1;
	};
   
AND: AND '&&' XOR
	{
		$$ = new Nodo("logico", "logico", "logico");
		$$.operacion = $2;
		$$.hijos[0] = $1;
		$$.hijos[1] = $3;
	}
	| AND '&?' XOR
	{
		$$ = new Nodo("logico", "logico", "logico");
		$$.operacion = $2;
		$$.hijos[0] = $1;
		$$.hijos[1] = $3;
	}
	| XOR
	{
	 $$ = $1;
	};
   
XOR: XOR '|&' NOT
	{
		$$ = new Nodo("logico", "logico", "logico");
		$$.operacion = $2;
		$$.hijos[0] = $1;
		$$.hijos[1] = $3;
	}
	| NOT
	{
	 $$ = $1;
	};
   
NOT: '!' REL
	{
		$$ = new Nodo("logico", "logico", "logico");
		$$.operacion = $1;
		$$.hijos[0] = $2;
	}
	| REL
	{
	 $$ = $1;
	};

REL: EXP OPREL EXP
	{
		$$ = new Nodo("relacional", "relacional", "relacional");
		$$.operacion = $2;
		$$.hijos[0] = $1;
		$$.hijos[1] = $3;
	}
	| EXP
	{
		$$ = $1;
	};

OPREL: '=='
	{
		$$ = "==";
	}
	| '!='
	{
		$$ = "!=";
	}
	| '<'
	{
		$$ = "<";
	}
	| '>'
	{
		$$ = ">";
	}
	| '<='
	{
		$$ = "<=";
	}
	| '>='
	{
		$$ = ">=";
	};
		
EXP : EXP '+' MUL
	{
		$$ = new Nodo("expresion", "expresion", "expresion");
		$$.operacion = '+';
		$$.hijos[0] = $1;
		$$.hijos[1] = $3;
	}
	| EXP '-' MUL
	{
		$$ = new Nodo("expresion", "expresion", "expresion");
		$$.operacion = '-';
		$$.hijos[0] = $1;
		$$.hijos[1] = $3;
	}
	| MUL
	{
		$$ = $1;
	};
	
MUL: MUL '*' POT
	{
		$$ = new Nodo("expresion", "expresion", "expresion");
		$$.operacion = '*';
		$$.hijos[0] = $1;
		$$.hijos[1] = $3;
	}
	| MUL '/' POT
	{
		$$ = new Nodo("expresion", "expresion", "expresion");
		$$.operacion = '/';
		$$.hijos[0] = $1;
		$$.hijos[1] = $3;
	} 
	| POT
	{
		$$ = $1;
	};

POT: NEG '^' POT
	{
		$$ = new Nodo("expresion", "expresion", "expresion");
		$$.operacion = '^';
		$$.hijos[0] = $1;
		$$.hijos[1] = $3;
	}
	| NEG '%' POT
	{
		$$ = new Nodo("expresion", "expresion", "expresion");
		$$.operacion = '%';
		$$.hijos[0] = $1;
		$$.hijos[1] = $3;
	}
	| NEG
	{
		$$ = $1;
	};
	
NEG: '-' VALOR
	{
		$$ = new Nodo("expresion", "expresion", "expresion");
		$$.operacion = "neg";
		$$.hijos[0] = $2;
	}
	| VALOR
	{
		$$ = $1;
	};
	

VALOR: tNumero
	{
		$$ = new Nodo("num", "num", "valor");
		$$.valor = yytext;
	}
	| tCadena
	{
		$$ = new Nodo("str", "str", "valor");
		$$.valor = yytext;
	}
	| tCaracter
	{
		$$ = new Nodo("car", "str", "valor");
		$$.valor = yytext;
	}
	| tTrue
	{
		$$ = new Nodo("bool", "bool", "valor");
		$$.valor = 1;
	}
	| tFalse
	{
		$$ = new Nodo("bool", "bool", "valor");
		$$.valor = 0;
	}
	| '(' LOG ')'
	{
		$$ = $2;
	}
	| tId VALOR_
	{
		$$ = $2;
		$$.nombre = $1;
	}
	| ACCESO
	{
		$$ = $1;
	}
	| nulo
	{
		$$ = new Nodo("null", "null", "null");
	};
	
VALOR_: '(' PARAMETROS ')'
	{
		$$ = new Nodo("funcion", "funcion", "funcion");
		$$.hijos[0] = $2;
	}
	| DIMENSIONES
	{
		$$ = new Nodo("arreglo", "arreglo", "arreglo");
		$$.hijos[0] = ($1);
	}
	|
	{
		$$ = new Nodo("variable", "variable", "variable");
	};

DIMENSIONES: DIMENSIONES '[' LOG ']'
			{
				$$ = $1;
				temp = new Nodo("dimension", "dimension", "dimension");
				$$.agregar(temp);
			}
			| '[' LOG ']'
			{
				$$ = new Nodo("dimension", "dimension", "dimension");
				$$.hijos[0] = $2;
			};

PARAMETROS: PARAMETROS ',' LOG
			{
				$$ = $1;
				$$.agregar($3);
			}
			| LOG
			{
				$$ = $1;
			}
			|
			{
				$$ = null;
			};
			
ACCESO: tId '.' ATRI
	{
		$$ = new Nodo($1, "variable", "acceso");
		$$.hijos[3] = $3;
	}
	| tId '(' PARAMETROS ')' '.' ATRI
	{
		$$ = new Nodo($1, "funcion", "acceso");
		$$.hijos[0] = $3;
		$$.hijos[3] = $6;
	};
	
ATRI: tId '.' ATRI
	{
		$$ = new Nodo($1, "variable", "variable");
		$$.hijos[3] = $3;
	}
	| tId
	{
		$$ = new Nodo($1, "variable", "variable");
	}
	| tId DIMENSIONES
	{
		$$ = new Nodo($1, "arreglo", "arreglo");
		$$.hijos[0] = $2;
	};
