

/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex

decimal [0-9]+("."[0-9]+)\b 
entero [0-9]+	              
caracter "'"([0-9]|[a-zA-Z])"'" 

tamanioArreglo  ((([a-zA-Z_])(([a-zA-Z_])|([0-9]))*)(".")("tamanio")) 
id  ([a-zA-Z_])(([a-zA-Z_])|([0-9]))*  


%%

\s+                   /* skip whitespace */



"Repetir_Mientras"  return 'Repetir_Mientras'
"hacer" return 'hacer'
"mientras" return 'mientras'
"Ciclo_doble_condicion" return 'Ciclo_doble_condicion'
"Repetir" return 'Repetir'
"hasta_que" return 'hasta_que'
"Repetir_contando" return 'Repetir_contando'
"variable" return 'variable'
"desde" return 'desde'
"hasta" return 'hasta'
"Enciclar" return 'Enciclar'
"Contador" return 'Contador'
"Leer_Teclado" return 'Leer_Teclado'
"Evaluar_si" return 'Evaluar_si'
"Es_igual_a" return 'Es_igual_a'
"defecto" return 'defecto'

"Es_falso" return 'Es_falso'
"Es_verdadero" return 'Es_verdadero'
"Si" return 'Si'
"Lista"  return 'Lista'
"Pila" return 'Pila'
"Cola" return 'Cola'
"insertar" return 'insertar'
"obtener" return 'obtener'
"buscar" return 'buscar'
"Encolar" return 'Encolar'
"Desencolar" return 'Desencolar'
"importar" 	return 'importar'
"@" return 'arroba'
"Sobreescribir" return 'sobreescribir'
"concatenar"   return 'concatenar'
"," return 'coma'
"convertirAEntero" return 'convertirAEntero'
"convertirACadena" return 'convertirACadena'
"imprimir" return 'imprimir'
"retorno" return 'retorno'
"romper" return 'romper'
"principal"  return 'principal'
"nuevo"  return 'nuevo'
"publico" return 'publico'
"protegido" return 'protegido'
"privado" return 'privado'
"continuar" return 'continuar'
"Nada" return 'nulo'
"{'\0'}" return 'nulo'
"{\"\0\"}"return 'nulo'

"hereda_de" return 'hereda_de'
"clase" return 'clase'

"puntero"		return 'puntero'
"vacio" 	return 'vacio'
"true"		      return 'booleano'
"false"               return 'booleano' 
"estructura"	return 'estructura'

"."					return 'punto'
"entero"			return 't_entero'
"caracter"			return 't_caracter'
"booleano"	       return 't_booleano'
"decimal"			return 't_decimal'

"+="                return 'masIgual'
"-="				return 'menosIgual'
"*="				return 'porIgual'
"/="				return 'divIgual'
"=" 				return 'igual'
	       
"*"                   return 'por'
"/"                   return 'division'
"-"                   return 'menos'
"+"                   return 'mas'
"^"                   return 'potencia'

"("                   return 'abrePar'
")"                   return 'cierraPar'

"{" 	return 'abreLlave'
"}"		return 'cierraLlave'

"["   	return 'abreCor'
"]"     return 'cierraCor'

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

";"      			return 'puntoComa'
":"					return 'dosPuntos'

{tamanioArreglo} return 'tamanioArreglo'

\"(\\.|[^"])*\"			return 'cadena';

{id}   return 'id'
{decimal} return 'decimal'
{entero} return 'entero'
{caracter} return 'caracter'


<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%left mas menos
%left por  division
%left potencia


%start INICIO

%% /* language grammar */


INICIO: CLASE EOF{console.log("llegue hasta aqui");};


IMPORTAR : importar abrePar cadena cierraPar puntoComa;

/*-------------------------------- Clases ---------------------------------*/

CLASE: clase id CUERPO_CLASE
	| clase id hereda_de id CUERPO_CLASE;


CUERPO_CLASE: abreLlave SENTENCIAS_CLASE cierraLlave
	|abreLlave cierraLlave;


/*--------------------------- Funciones ----------------------------------*/

PARAMETRO: TIPO_DECLARACION id 
	|TIPO_DECLARACION puntero id
	|TIPO_DECLARACION id COL_ARREGLO
	|TIPO_DECLARACION puntero id COL_ARREGLO;

PARAMETROS: PARAMETRO
	|PARAMETROS coma PARAMETRO;

LISTA_PARAMETROS : abrePar PARAMETROS cierraPar
	|abrePar  cierraPar;

FUNCION_SOBRE: arroba sobreescribir FUNCION;

FUNCION: VISIBILIDAD TIPO_DECLARACION id  LISTA_PARAMETROS  CUERPO_FUNCION
	|VISIBILIDAD vacio id  LISTA_PARAMETROS CUERPO_FUNCION
	| TIPO_DECLARACION id  LISTA_PARAMETROS  CUERPO_FUNCION
	| vacio id  LISTA_PARAMETROS CUERPO_FUNCION;


PRINCIPAL: principal abrePar cierraPar CUERPO_FUNCION;

CONSTRUCTOR: VISIBILIDAD id  LISTA_PARAMETROS  CUERPO_FUNCION
	|id LISTA_PARAMETROS CUERPO_FUNCION;


CUERPO_FUNCION: abreLlave SENTENCIAS cierraLlave
	| abreLlave cierraLlave;


SENTENCIAS_CLASE: SENTENCIA_CLASE 
	|SENTENCIAS_CLASE SENTENCIA_CLASE;


SENTENCIA_CLASE: ATRIBUTO
	|FUNCION
	|FUNCION_SOBRE
	|PRINCIPAL
	|CONSTRUCTOR;		


SENTENCIAS: SENTENCIA
	|SENTENCIAS SENTENCIA;


SENTENCIA: DECLARACION
	|CONCATENAR
	|IMPRIMIR
	|ROMPER
	|RETORNO
	|EXPRESION
	|CONTINUAR
	|ESTRUCTURA
	|INSERTA_LISTA
	|APILAR
	|DESAPILAR
	|ENCOLAR
	|DESENCOLAR
	|DECLA_LISTA
	|DECLA_PILA
	|DECLA_COLA
	|SI
	|SWITCH
	|REPETIR_MIENTRAS
	|HACER_MIENTRAS
	|CICLO_X
	|REPETIR
	|REPETIR_CONTANDO
	|ENCICLAR
	|CONTADOR
	|LEER_TECLADO;




INSERTA_LISTA: id punto insertar abrePar EXPRESION cierraPar puntoComa;

OBTENER_LISTA: id punto obtener abrePar EXPRESION cierraPar puntoComa;

INDICE_LISTA: id punto buscar abrePar EXPRESION cierraPar puntoComa;



APILAR: id punto Apilar abrePar EXPRESION cierraPar puntoComa;

DESAPILAR: id punto Desapilar abrePar cierrPar puntoComa;

ENCOLAR: id punto Encolar abrePar EXPRESION cierraPar puntoComa;

DESENCOLAR: id punto Desencolar abrePar cierraPar puntoComa;

DECLA_LISTA: Lista id igual nuevo Lista abrePar TIPO_EXPRESION cierraPar puntoComa;

DECLA_PILA: Pila id igual nuevo Pila abrePar TIPO_EXPRESION cierraPar puntoComa;

DECLA_COLA: Cola id igual nuevo Cola abrePar TIPO_EXPRSEION cierraPar puntoComa;




/*--------------------- Estrucuras de Control -------------------------*/








SI_FALSO: Es_falso CUERPO_FUNCION;
SI_VERDADERO: Es_verdadero CUERPO_FUNCION;

CUERPO_SI: abreLlave cierraLlave
	|abreLlave SI_VERDADERO SI_FALSO cierraLlave
    |abreLlave SI_VERDADERO cierraLlave
    |abreLlave SI_FALSO cierraLlave
    |abreLlave SI_FALSO SI_VERDADERO cierraLlave;



SI: Si abrePar EXPRESION cierraPar CUERPO_SI;



CASO: Es_igual_a EXPRESION dosPuntos  SENTENCIAS;
DEFECTO: defecto dosPuntos SENTENCIAS;

LISTA_CASOS: CASO
	|LISTA_CASOS CASO;

CUERPO_SWITCH: LISTA_CASOS DEFECTO
	|LISTA_CASOS
	|DEFECTO;



SWITCH: Evaluar_si abrePar EXPRESION cierraPar abreLlave CUERPO_SWITCH cierraLlave
	| Evaluar_si abrePar EXPRESION cierraPar abreLlave  cierraLlave;




REPETIR_MIENTRAS: Repetir_Mientras abrePar EXPRESION cierraPar CUERPO_FUNCION;

HACER_MIENTRAS: hacer CUERPO_FUNCION mientras abrePar EXPRESION cierraPar puntoComa;

CICLO_X: Ciclo_doble_condicion abrePar EXPRESION coma EXPRESION cierraPar CUERPO_FUNCION;

REPETIR: Repetir CUERPO_FUNCION hasta_que abrePar EXPRESION cierraPar puntoComa;

REPETIR_CONTANDO: Repetir_contando abrePar variable dosPuntos id puntoComa desde dosPuntos EXPRESION puntoComa hasta dosPuntos EXPRESION cierraPar
CUERPO_FUNCION;


ENCICLAR: Enciclar id CUERPO_FUNCION;

CONTADOR: Contador abrePar EXPRESION cierraPar CUERPO_FUNCION;

LEER_TECLADO: Leer_Teclado abrePar EXPRESION coma id cierraPar puntoComa;







DECLARACION:  TIPO_DECLARACION id igual EXPRESION puntoComa
	|TIPO_DECLARACION id puntoComa
	|TIPO_DECLARACION id COL_ARREGLO puntoComa;



COL_ARREGLO: abreCor EXPRESION cierraCor
	| COL_ARREGLO abreCor EXPRESION cierraCor;	


CONCATENAR:	concatenar abrePar id coma EXPRESION coma EXPRESION cierraPar puntoComa {console.log("concatenar 3");}
	|concatenar abrePar id coma EXPRESION cierraPar puntoComa {console.log("concatenar 2");};


IMPRIMIR: imprimir abrePar EXPRESION cierraPar puntoComa;


RETORNO: retorno EXPRESION puntoComa
	|retorno puntoComa;


ROMPER: romper puntoComa;

CONTINUAR: continuar puntoComa;


ESTRUCTURA: estructura id abreCor LISTA_DECLARACIONES cierraCor puntoComa;

LISTA_DECLARACIONES: DECLARACION
	|LISTA_DECLARACIONES DECLARACION;


SIMB_IGUAL: igual
	|masIgual
	|menosIgual
	|porIgual
	|divIgual;


TIPO_DECLARACION: t_entero
	|t_caracter
	|t_decimal
	|t_booleano
	|id;




VISIBILIDAD: publico 
	|protegido
	|privado;

ATRIBUTO: VISIBILIDAD DECLARACION
	|DECLARACION;



/*--------------------------- Expresion ----------------------------------*/

LISTA_EXPRESIONES: EXPRESION
	|LISTA_EXPRESIONES EXPRESION;

PARAMETROS_LLAMADA : abrePar cierraPar
	|abrePar LISTA_EXPRESIONES cierraPar;

LLAMADA: id PARAMETROS_LLAMADA;


INSTANCIA: nuevo id PARAMETROS_LLAMADA;

EXPRESION: TERMINAL_EXPRESION
	|CONVERTIR_A_CADENA
	|CONVERTIR_A_ENTERO
	|INSTANCIA
	|LLAMADA
	|OBTENER_LISTA
	|INDICE_LISTA
	|nulo;


CONVERTIR_A_CADENA: convertirACadena abrePar EXPRESION cierraPar puntoComa;

CONVERTIR_A_ENTERO: convertirAEntero abrePar EXPRESION cierraPar puntoComa;


TERMINAL_EXPRESION: entero{var num = new Entero(); num.setNumero($1); $$= num;}
	|decimal{var num = new Decimal(); num.setNumero($1); $$=num;}
	|caracter{var car= new Caracter(); car.setValorCaracter($1); $$=car;}
	|booleano{var bol= new Booleano(); bol.setValorBooleano($1); $$=bol;}
	|abrePar EXPRESION cierraPar
	|tamanioArreglo {console.log("tamanio");}
	|cadena;


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








	
	
