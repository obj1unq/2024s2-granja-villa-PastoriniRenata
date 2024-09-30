import wollok.game.*
import hector.*

class Maiz {
	var property position = game.at(1, 1)
	var property estado = "bebe" // adulto
	
	
	method image(){
		return if(estado == "bebe"){
					"corn_baby.png"
				}else{
					 "corn_adult.png"
				}
	}

	method esAdulto() {
		return estado == "adulto"
	}

	method precio(){
		return 150
	}



}

class Trigo {
	var property position = game.at(1, 1)
	var property estado = "bebe" // adulto_1 adulto_2 adulto_3

	method image(){
		return if(estado == "bebe"){
					"wheat_0.png"
				}else if(estado == "adulto_1"){
					"wheat_1.png"
				}else if(estado == "adulto_2"){
					"wheat_2.png"
				}else{
					"wheat_3.png"
				}
	}
	method esAdulto() {
		return estado != "bebe"
	}
	method precio(){
		return (self.etapa() - 1) * 100
	}

	method etapa(){
		return if(estado == "bebe"){
			0
		}else if(estado == "adulto_1"){
			1
		}else if(estado == "adulto_2"){
			2
		}else{ //
			3
		}
	}
}

class Tomaco {
	var property position = game.at(1, 1)
	var property estado = "bebe" // adulto
	
	method image(){
		return if(estado == "bebe"){
					"tomaco_baby.png"
				}else{
					"tomaco.png"
				}
		}
	method esAdulto() {
		return estado == "adulto"
	}
	method precio(){
		return 80
	}
}


