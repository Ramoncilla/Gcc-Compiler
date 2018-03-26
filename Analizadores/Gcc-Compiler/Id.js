
function Id(){
	this.nombreId="";
}

Id.prototype.nombreId="";


Id.prototype.setValorId = function(valor) {
 	Id.prototype.nombreId=valor;
};

Id.prototype.getValorId= function(){
	return Id.prototype.nombreId;
};



