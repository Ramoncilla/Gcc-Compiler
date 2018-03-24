function llamada(){

	this.nombreFuncion="";
	this.parametros =[];
}


llamada.prototype.nombreFuncion="";
llamada.prototype.parametros=[];



llamada.prototype. setValoresLlamada= function(nombre, parametros) {
	// body...
	llamada.prototype.nombreFuncion = nombre;
	llamada.prototype.parametros=parametros;
};


llamada.prototype.getNombreFuncion = function() {
	return llamada.prototype.nombreFuncion;
	// body...
};


llamada.prototype.getParametros = function() {
	return llamada.prototype.parametros;
	// body...
};

