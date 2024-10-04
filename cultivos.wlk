import wollok.game.*
import hector.*
import granja.*

/*
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

	method regar(){
		self.validarEvolucion()
		etapa = 1
	}

	method validarEvolucion(){
		if(self.esAdulto()){
			game.say(hector,"Ya es una planta adulta")
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
	
	method regar(){
		
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
	method validarEvolucion(){
			// x polimnorfismo, el trigo siempre evoluciona
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


	method regar(){
		self.validarEvolucion()
		position = granja.primeraPosicionLibreEnColumna(game.at(position.x(), position.y()+1))
		etapa = 1
	}

	method validarEvolucion(){
		if(self.esAdulto()){
			game.say(hector,"Ya es una planta adulta")
		}
	}

}

*/

class Maiz {
	var property position = game.at(1, 1)
	var property etapa = evolMaizBebe // es bebe y adulto es 1
	
	method image(){
		return etapa.image()
	}
	
	method precio(){
		return 150
	}

	method esAdulto(){
		return etapa.esAdulto()
	}

	method regar(){
		//self.validarRegar()--> no hace falta validar xq en su etapa adulta, con el metodo siuiente, no cambia la insatncia, basicamente t devuelve la misma
		etapa = etapa.siguiente()
	}

	method validarRegar(){
		if(self.esAdulto()){
			hector.error("Ya es una planta adulta")
		}
	}

}

object evolMaizBebe {
	var property image = "corn_baby.png"

	method siguiente() = evolMaizAdulto

	method esAdulto() = false
	method etapa() = 0 //x polimorfismo?
	
}
object evolMaizAdulto {
	var property image = "corn_adult.png"

	method siguiente() = self //x polimorfismo, xq en realidad no cambia

	method esAdulto() = true
	method etapa() = 1 //x polimorfismo?

	
}





class Trigo {
	var property position = game.at(1, 1)
	var property etapa = evolTrigoBebe 

	method image(){
		return etapa.image()
	}
	
	method esAdulto(){
		return etapa.esAdulto()
	}
	method regar(){
		etapa = etapa.siguiente()
	}

	method validarRegar(){
		//por polimorfismo
	}

	method precio(){
		return (etapa.etapa() - 1) * 100
	}
	

}

object evolTrigoBebe {
	var property image = "wheat_0.png"

	method siguiente() = evolTrigoAdulto1

	method esAdulto() = false

	method etapa() = 0
	
}
object evolTrigoAdulto1 {
	var property image = "wheat_1.png"

	method siguiente() = evolTrigoAdulto2

	method esAdulto() = true
	method etapa() = 1

	
}
object evolTrigoAdulto2 {
	var property image = "wheat_2.png"

	method siguiente() = evolTrigoAdulto3

	method esAdulto() = true
	method etapa() = 2

	
}
object evolTrigoAdulto3 {
	var property image = "wheat_3.png"

	method siguiente() = evolTrigoBebe

	method esAdulto() = true
	method etapa() = 3
	

	
}




class Tomaco {
	var property position = game.at(1, 1)
	var property image = "tomaco.png"

	method precio(){
		return 80
	}
	
	method esAdulto(){
		return true
	}

	method regar(){
		/*
		al momento de regar, muevo la planta de tomaco a la siguiente posicion libre en el tablero, en caso de no existir una posicion libre, se queda en el mismo lugar
		Puedo regarlo muchas veces, en ningun lugar aclara q no se puede regar mas d una vez
		*/
		
		position = granja.siguientePosicionSiEstaLibre(position) //si no encuentra ninguna, se queda en el lugar!
		
	}



}

