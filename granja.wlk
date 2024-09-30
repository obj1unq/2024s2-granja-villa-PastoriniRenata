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
    var property sembrado = #{}// #{new Trigo(position=game.at(1,0)), new Trigo(position=game.at(1,1)),new Trigo(position=game.at(1,2)),new Trigo(position=game.at(1,3)), new Trigo(position=game.at(1,4)),new Trigo(position=game.at(1,5)),new Trigo(position=game.at(1,6)),new Trigo(position=game.at(1,7))}


	method validarDentro(posicion) {
		if (not self.estaDentro(posicion)) {
			self.error('No puedo moverme fuera del tablero')
		}
	}

	method estaDentro(posicion) {
		return posicion.x().between(0, game.width() - 1) and posicion.y().between(0, game.height() - 1)
	}
    method sembrar(planta){
        sembrado.add(planta)
    }

	method hayPlantaEn(pos){
		return sembrado.any({cultivo => cultivo.position().x()==pos.x() and cultivo.position().y()==pos.y() })
	}

	method esMismaPosition(pos1, pos2){
		return pos1.x() == pos2.x() and pos1.y() == pos2.y()

	}
	method campoSinPlantaEn(_position){
		return sembrado.filter({planta => not self.esMismaPosition(planta.position(), _position)})

	}

	method plantaEn(_position){
		return sembrado.find({planta => self.esMismaPosition(planta.position(), _position)})
	}

	method crecerPlanta(_position) {
		//La ejecuto sabiendo que hay una planta en la posicion pasada!
		const plantaEnPosition = self.plantaEn(_position) // la guardo antes de borrarla para despues borrar el visual y poder regarla
		sembrado = self.campoSinPlantaEn(_position) //saco la planta sin regar

		const plantaEvolucionada = self.evolucionar(plantaEnPosition)
		
		game.removeVisual(plantaEnPosition)
		game.addVisual(plantaEvolucionada)
		
		self.sembrar(plantaEvolucionada)

	
	}

	method evolucionar(planta){
		
		 return if(planta.image() == 'corn_baby.png'){
					new Maiz (position = planta.position(), estado = "adulto" )
				
				
				}
				else if(planta.image() == 'tomaco_baby.png'){
					const sigPositEnCol = game.at(planta.position().x(), planta.position().y()+1)
					const nuevaPosTomaco = self.primeraPosicionLibreEnColumna(sigPositEnCol)
					new Tomaco(position = nuevaPosTomaco, estado = "adulto" ) // mueve el tomaco 1 posicion mas arriba, si ya está ocupada, a la siguiente disponible,
																				// y si llega al borde, lo pone abajo d todo. En caso de tambien estar ocupada, se fija en la de arriba d esa
																				// puede q termien poniendolo en su posicion inicial en caso de estar toda la fila ocupada
													
				
				//EN CASO DE SER UN TOMACO "ADULTO" LO TENGO Q MOVER TAMBIEN??
				
				}else if(self.esAlgunaEvolucionDeTrigo(planta.image())){ //caso en el que sea trigo o la planta ya sea Maiz adulto.
					self.evolucionarTrigo(planta)
				}else{
					planta
				}
	}

	method esAlgunaEvolucionDeTrigo(imagPlanta){
		const evoluciones = ['wheat_0.png','wheat_1.png','wheat_2.png','wheat_3.png']
		return evoluciones.any({evol => evol == imagPlanta})

	}
	method evolucionarTrigo(planta){
		//yo tengo la certeza de que esto lo voy a ejecutar sabiendo q la planta es una evolucion d tomaco es uno de los elementos de la lista de evoluciones
		//const evoluciones = ['wheat_0.png','wheat_1.png','wheat_2.png','wheat_3.png']
			return 	if(planta.estado() == "bebe"){ 
					    new Trigo (position=planta.position(), estado = "adulto_1" )
					}else if(planta.estado() == "adulto_1" ){ 
						new Trigo (position=planta.position(), estado = "adulto_2" )
					}else if(planta.estado() == "adulto_2" ){ 
						new Trigo (position=planta.position(), estado = "adulto_3" )
					}else { 
						new Trigo (position=planta.position(), estado = "bebe" )
					}

	}

	method primeraPosicionLibreEnColumna(posicion) {
		// Si la posición está dentro de los límites
			if (self.estaDentro(posicion)) {
				// Si hay una planta en la posición, buscar en la siguiente
				if (self.hayPlantaEn(posicion)) {
					return self.primeraPosicionLibreEnColumna(game.at(posicion.x(), posicion.y() + 1))
				} else {
					// Si no hay planta, devolver la posición actual
					return posicion
				}
			} else {
				// Si está fuera de los límites, reiniciar la búsqueda desde la parte superior
				return self.primeraPosicionLibreEnColumna(game.at(posicion.x(), 0))
		}

	}




	method cosechar(posit){
		//ya se q hay una planta en la posicion pasada por parametro y q es adulta!
		
		const plantaEnPosition = sembrado.find({planta => self.esMismaPosition(planta.position(), posit)})
		game.removeVisual(plantaEnPosition)
		
		sembrado = sembrado.filter({planta => not self.esMismaPosition(planta.position(), posit)}) //saco la planta 
	
	}

	method validarCosecha(posit){
		if(not self.hayPlantaYEsAdultaEn(posit)){
			self.error("No hay nada para cosechar")
		}
	}


	method hayPlantaYEsAdultaEn(posit){
		return self.hayPlantaEn(posit) and self.plantaEn(posit).esAdulto()
	}


}