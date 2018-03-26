function Clase(){
	this.nombre ="";
	this.herencia = "";
	this.sentencias=[];
}

Clase.prototype.nombre="";
Clase.prototype.herencia="";
Clase.prototype.sentencias=[];

Clase.prototype.setValores = function(nombre, here, sent) {
	Clase.prototype.nombre= nombre;
	Clase.prototype.herencia= here;
	Clase.prototype.sentencias=sent;
};

Clase.prototype.getNombre= function(){
	return Clase.prototype.nombre;
};


Clase.prototype.getHerencia= function(){
	return Clase.prototype.herencia;
};


Clase.prototype.getSentencias= function(){
	return Clase.prototype.sentencias;
};
