
function posArreglo(){

	this.nombreArreglo="";
	this.posicionesArreglo =[];
}


posArreglo.prototype.nombreArreglo="";
posArreglo.prototype.posicionesArreglo=[];


posArreglo.prototype.setValores = function(nombre, posiciones) {
	// body...
	posArreglo.prototype.nombreArreglo=nombre;
	posArreglo.prototype.posicionesArreglo= posiciones;
};


posArreglo.prototype.getNombreArreglo = function() {
	
	return posArreglo.prototype.nombreArreglo;
};


posArreglo.prototype.getPosicionesArreglo = function() {
	// body...
	return posArreglo.prototype.posicionesArreglo;
};


