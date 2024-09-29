import wollok.game.*
import hector.*
import cultivos.*

object arriba {
	method siguiente(posicion) {
		return posicion.up(1)
	}
}

object abajo {
	method siguiente(posicion) {
		return posicion.down(1)
	}	
}

object izquierda {
	method siguiente(posicion) {
		return posicion.left(1)
	}
}
object derecha {
	method siguiente(posicion) {
		return posicion.right(1)
	}
}

object granja {
    var property sembrado =  #{new Trigo(position=game.at(1,5))}


	method validarDentro(posicion) {
		if (not self.estaDentro(posicion)) {
			self.error("No puedo moverme fuera del tablero")
		}
	}

	method estaDentro(posicion) {
		return posicion.x().between(0, game.width() - 1) and posicion.y().between(0, game.height() - 1)
	}
    method sembrar(cultivo){
        sembrado.add(cultivo)
    }

	method hayPlantaEn(pos){
		return sembrado.any({cultivo => cultivo.position().x()==pos.x() and cultivo.position().y()==pos.y() })
	}

	method esMismaPosition(pos1, pos2){
		return pos1.x() == pos2.x() and pos1.y() == pos2.y()

	}

	method crecerPlanta(_position) {
		if( self.hayPlantaEn(_position)){
			const nuevoSembrado = sembrado.filter({planta => not self.esMismaPosition(planta.position(), _position)})
			const plantaEnPosition = sembrado.find({planta => self.esMismaPosition(planta.position(), _position)})
			const plantaEvolucionada = self.regar(plantaEnPosition)
			
			sembrado = nuevoSembrado.add(plantaEvolucionada)

			}
	}

	method regar(planta){
		
		 return if(planta.image() == "corn_baby.png"){
					new Maiz (position = planta.position(), image = "corn_adult.png" )
				}else if(planta.image() == "tomaco.png"){
					self.moverTomaco(planta) // mueve el tomaco 1 posicion mas arriba, si ya está ocupada, a la siguiente disponible,
											// y si llega al borde, lo pone abajo d todo. En caso de tambien estar ocupada, se fija en la de arriba d esa
											// puede q termien poniendolo en su posicion inicial en caso de estar toda la fila ocupada
				
				}else if(self.esAlgunaEvolucionDeTrigo(planta.image())){ //caso en el que sea trigo o la planta ya sea Maiz adulto.
					self.evolucionarTrigo(planta)
				}

	}

	method esAlgunaEvolucionDeTrigo(imagPlanta){
		const evoluciones = ["wheat_0.png","wheat_1.png","wheat_2.png","wheat_3.png"]
		return evoluciones.any({evol => evol == imagPlanta})

	}
	method evolucionarTrigo(planta){
		//yo tengo la certeza de que esto lo voy a ejecutar sabiendo q la planta es una evolucion d tomaco es uno de los elementos de la lista de evoluciones
		//const evoluciones = ["wheat_0.png","wheat_1.png","wheat_2.png","wheat_3.png"]
			return 	if(planta.image() == "wheat_0.png"){ 
					new Trigo (position=planta.position(), image = "wheat_1.png" )
				}else if(planta.image()  == "wheat_1.png"){ 
					new Trigo (position=planta.position(), image = "wheat_2.png" )
				}else if(planta.image()  == "wheat_2.png"){ 
					new Trigo (position=planta.position(), image = "wheat_3.png" )
				}else { 
					new Trigo (position=planta.position(), image = "wheat_0.png" )
				}

	}

	method moverTomaco(planta){
		
	}

    
}