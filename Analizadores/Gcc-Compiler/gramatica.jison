

/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex

%options case-insensitive

decimal [0-9]+("."[0-9]+)\b 
entero [0-9]+	              
caracter "'"([0-9]|[a-zA-Z])"'" 

tamanioArreglo  ((([a-zA-Z_])(([a-zA-Z_])|([0-9]))*)(".")("tamanio")) 
id  ([a-zA-Z_])(([a-zA-Z_])|([0-9]))*  


%%

\s+                   /* skip whitespace */


"tamanio" return 'tamanio'
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
"este" return 'este'

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

"++"	return 'masMas'
"--" 	return 'menosMenos'
	       
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

//{tamanioArreglo} return 'tamanioArreglo'

\"(\\.|[^"])*\"			return 'cadena';

{id}   return 'id'
{decimal} return 'decimal'
{entero} return 'entero'
{caracter} return 'caracter'


<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */



%left or
%left xor
%left and
%left not
%left igualIgual distintoA menorIgual mayorIgual mayor menor
%left mas menos
%left por  division
%left potencia
%left masMas menosMenos
%left abrePar






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


VISIBILIDAD: publico 
	|protegido
	|privado;

ATRIBUTO: VISIBILIDAD DECLARACION
	|DECLARACION
	|DECLA_LISTA
	|DECLA_PILA
	|DECLA_COLA
	|ESTRUCTURA
	|VISIBILIDAD DECLA_LISTA
	|VISIBILIDAD DECLA_COLA
	|VISIBILIDAD DECLA_PILA
	|VISIBLIDAD ESTRUCTURA;


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
	|CONTINUAR
	|ESTRUCTURA
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
	|LEER_TECLADO
	|ACCESO puntoComa
	|ASIGNACION puntoComa;


DECLA_LISTA: Lista id igual nuevo Lista abrePar TIPO_EXPRESION cierraPar puntoComa;

DECLA_PILA: Pila id igual nuevo Pila abrePar TIPO_EXPRESION cierraPar puntoComa;

DECLA_COLA: Cola id igual nuevo Cola abrePar TIPO_EXPRSEION cierraPar puntoComa;



DECLARACION:  TIPO_DECLARACION id igual EXPRESION puntoComa
	|TIPO_DECLARACION id puntoComa
	|TIPO_DECLARACION id COL_ARREGLO puntoComa
	|TIPO_DECLARACION id COL_ARREGLO igual EXPRESION puntoComa
	|TIPO_DECLARACION id igual INSTANCIA puntoComa;


ASIGNACION: id SIMB_IGUAL EXPRESION 
	|id igual INSTANCIA
	|ACCESO SIMB_IGUAL EXPRESION
	|ACCESO igual INSTANCIA
	|id masMas
	|id menosMenos
	|ACCESO masMas
	|ACCESO menosMenos
	|id COL_ARREGLO SIMB_IGUAL EXPRESION 
	|este punto id SIMB_IGUAL EXPRESION 
	|este punto id igual INSTANCIA
	|este punto ACCESO SIMB_IGUAL EXPRESION
	|este punto ACCESO igual INSTANCIA
	|este punto id masMas
	|este punto id menosMenos
	|este punto ACCESO masMas
	|este punto ACCESO menosMenos
	|este punto id COL_ARREGLO SIMB_IGUAL EXPRESION;

INSTANCIA: nuevo id PARAMETROS_LLAMADA;

SIMB_IGUAL: igual
	|masIgual
	|menosIgual
	|porIgual
	|divIgual;

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



TIPO_DECLARACION: t_entero
	|t_caracter
	|t_decimal
	|t_booleano
	|id;


/*--------------------------- Expresion ----------------------------------*/


EXPRESION: LOGICA;

LOGICA: LOGICA or XOR
	|XOR;

XOR: XOR xor AND
	|AND;

AND: AND and NOT
	|NOT;

NOT: not REL
	|REL;

REL: ARITMETICA SIMB_REL ARITMETICA
	|ARITMETICA;

SIMB_REL: menor
	|mayor
	|menorIgual
	|mayorIgual
	|distintoA
	|igualIgual;

ARITMETICA: ARITMETICA mas MUL
	|ARITMETICA menos MUL
	|MUL;

MUL: MUL por POT
	|MUL division POT
	|POT;

POT: UNARIO potencia POT
	|UNARIO;

UNARIO: NEG masMas
	|NEG menosMenos
	|NEG;	

NEG: menos VALOR
	|VALOR;

VALOR: entero{var num = new Entero(); num.setNumero($1); $$= num;}
	|decimal{var num = new Decimal(); num.setNumero($1); $$=num;}
	|caracter{var car= new Caracter(); car.setValorCaracter($1); $$=car;}
	|booleano{var bol= new Booleano(); bol.setValorBooleano($1); $$=bol;}
	|abrePar EXPRESION cierraPar{ $$=$1;}
	|cadena {var n = new Cadena(); n.setCadena($1); $$=n;}
	|nulo {var n = new Nulo(); n.setNulo(); $$=n;}
	|CONVERTIR_CADENA
	|CONVERTIR_ENTERO
	|id {var i = new Id(); i.setValorId($1); $$= i;}
	|id COL_ARREGLO{var i = new posArreglo(); i.setValores($1, $2); $$=i;}
	|id PARAMETROS_LLAMADA {var i = new llamada(); i.setValoresLlamada($1, $2); $$= i;}
	|ACCESO
	|este punto ACCESO
	|este punto id
	|este punto id COL_ARREGLO
	|este punto id PARAMETROS_LLAMADA
	|CUERPO_ARREGLO;	

ACCESO: id punto ATRI;


ATRI_:id
	|id COL_ARREGLO
	|id PARAMETROS_LLAMADA
	|insertar abrePar EXPRESION cierraPar
	|Apilar abrePar EXPRESION cierraPar
	|Desapilar abrePar cierrPar
	|Encolar abrePar EXPRESION cierraPar
	|Desencolar abrePar cierraPar
	|obtener abrePar EXPRESION cierraPar
	|buscar abrePar EXPRESION cierraPar
	|tamanio;
	

ATRI: ATRI_ 
	|ATRI punto ATRI_;

LISTA_EXPRESIONES: EXPRESION
	|LISTA_EXPRESIONES coma EXPRESION;


PARAMETROS_LLAMADA : abrePar cierraPar
	|abrePar LISTA_EXPRESIONES cierraPar;


CUERPO_ARREGLO: abreLlave LISTA_CUERPO_ARREGLO cierraLlave;


LISTA_CUERPO_ARREGLO: ELEMENTO_FILA
	|LISTA_CUERPO_ARREGLO coma ELEMENTO_FILA;


ELEMENTO_FILA : abreLlave LISTA_EXPRESIONES cierraLlave;
	

CONVERTIR_A_CADENA: convertirACadena abrePar EXPRESION cierraPar puntoComa;

CONVERTIR_A_ENTERO: convertirAEntero abrePar EXPRESION cierraPar puntoComa;




