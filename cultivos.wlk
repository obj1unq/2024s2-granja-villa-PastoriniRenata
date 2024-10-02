import wollok.game.*
import hector.*
import granja.*


class Maiz {
	var property position = game.at(1, 1)
	var property etapa = 0 // es bebe y adulto es 1
	
	
	method image(){
		return if(etapa == 0){
					"corn_baby.png"
				}else{
					 "corn_adult.png"
				}
	}

	method precio(){
		return 150
	}
	method siguienteEvolucion(){
		if(etapa == 0){
			etapa = 1
		}
	}

	method esAdulto(){
		return etapa == 1
	}

	method evolucionar(){
		self.validarEvolucion()
		etapa = 1
	}

	method validarEvolucion(){
		if(self.esAdulto()){
			self.error("Ya es una planta adulta")
		}
	}



}

class Trigo {
	var property position = game.at(1, 1)
	var property etapa = 0 // es bebe y 1, 2 y 3 son adultos

	method image(){
		return if(etapa == 0){
					"wheat_0.png"
				}else if(etapa == 1){
					"wheat_1.png"
				}else if(etapa == 2){
					"wheat_2.png"
				}else{
					"wheat_3.png"
				}
	}

	method siguienteEvolucion(){
		if(etapa == 3){
			etapa =0
		}else{
			etapa +=1
		}
	}

	method esAdulto(){
		return etapa>0 and etapa<4
	}

	method precio(){
		return (self.etapa() - 1) * 100
	}
	
	method evolucionar(){
		
		if(etapa == 0){ 
			etapa = 1
		}else if(etapa == 1 ){ 
			etapa = 2
		}else if(etapa == 2 ){ 
			etapa = 3 
		}else { 
			etapa = 0
		}
}
	





}

class Tomaco {
	var property position = game.at(1, 1)
	var property etapa = 0 // es bebe y adulto es 1
	
	method image(){
		return if(etapa == 0){
					"tomaco_baby.png"
				}else{
					"tomaco.png"
				}
		}

	method precio(){
		return 80
	}
	method siguienteEvolucion(){
		if(etapa == 0){
			etapa = 1
		}
	}
	method esAdulto(){
		return etapa == 1
	}


	method evolucionar(){
		self.validarEvolucion()
		position = granja.primeraPosicionLibreEnColumna(game.at(position.x(), position.y()+1))
		etapa = 1
	}

	method validarEvolucion(){
		if(self.esAdulto()){
			self.error("Ya es una planta adulta")
		}
	}

}







