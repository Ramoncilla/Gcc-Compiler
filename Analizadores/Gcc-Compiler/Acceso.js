function Acceso(){

	this.nombreObjeto="";
	this.elementosAcceso =[];
}


Acceso.prototype.nombreObjeto="";
Acceso.prototype.elementosAcceso=[];



Acceso.prototype.setValoresAcceso= function(nombre, elementosAcceso) {
	// body...
	Acceso.prototype.nombreObjeto = nombre;
	Acceso.prototype.elementosAcceso=elementosAcceso;
};


Acceso.prototype.getnombreObjeto = function() {
	return Acceso.prototype.nombreObjeto;
	// body...
};


Acceso.prototype.getelementosAcceso = function() {
	return Acceso.prototype.elementosAcceso;
	// body...
};

