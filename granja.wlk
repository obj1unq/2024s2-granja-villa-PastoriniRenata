import wollok.game.*
import hector.*
import cultivos.*
import mercado.*


object granja {
    var property sembrado = #{}// #{new Trigo(position=game.at(1,0)), new Trigo(position=game.at(1,1)),new Trigo(position=game.at(1,2)),new Trigo(position=game.at(1,3)), new Trigo(position=game.at(1,4)),new Trigo(position=game.at(1,5)),new Trigo(position=game.at(1,6)),new Trigo(position=game.at(1,7))}
	var property mercados = #{}


	method validarDentro(posicion) {
		if (not self.estaDentro(posicion)) {
			hector.error("No puedo moverme fuera del tablero")
		}
	}

	method estaDentro(posicion) {
		return posicion.x().between(0, game.width() - 1) and posicion.y().between(0, game.height() - 1)
	}

    method sembrar(planta){
        sembrado.add(planta)
    }

	method validarSiPuedoPlantar(posit) {
		if ( self.hayPlantaEn(posit)){
				hector.error("No puedes plantar, ya hay una planta aquí") 
		}else if( self.hayMercado(posit)){
				hector.error("No puedes plantar, hay un mecado aquí") 
		} 
	}

	method hayPlantaEn(pos){
		return sembrado.any({cultivo => cultivo.position() == pos })
	}

	method hayMercado(posit){
		return posit == game.at(0,0) or posit == game.at(9,9)
	}

	method agregarMercados(){
		const mercado1 = new Mercado (position = game.at (0,0))
		const mercado2 = new Mercado (position = game.at (9,9))

		mercados.add(mercado1)
		mercados.add(mercado2)

		game.addVisual(mercado1)
		game.addVisual(mercado2)

	}

	method mercadoEn(pos){
		return mercados.find({mercado => mercado.position() == pos})
	}

	method validarSiHayMercado(pos){
		if(not self.hayMercado(pos)){
			hector.error("No puedo vender, no estoy en un mercado")
		}
	}

	method validarSiPuedeVenderEn(pos, valor){
		//ya se q tengo un mercado en esa pos!!

		if(not self.mercadoEn(pos).tieneSuficienteDinero(valor)){
			hector.error("No puede vender, el mercado no tiene suficiente dinero")
		}else if(not hector.tieneMercaderia()){
			hector.error("No tengo mercancia que vender")
		}else{
			game.say(self, "Venta realizada!")
		}
	}
	method elMercadoCompra(pos){
		self.mercadoEn(pos).compra()
	}
	

	method esMismaPosition(pos1, pos2){
		return pos1 == pos2

	}
	method campoSinPlantaEn(_position){
		return sembrado.filter({planta => not self.esMismaPosition(planta.position(), _position)})

	}

	method regarPlanta(_position) {
		self.validarRegar(_position)
		self.plantaEn(_position).regar()
	}
	method validarRegar(posit){
		if (not self.hayPlantaEn(posit)){ hector.error("No hay nada para regar") }
	}

	method plantaEn(_position){
		return sembrado.find({planta => self.esMismaPosition(planta.position(), _position)})
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

	method validarSiPuedoCosechar(posit){
		if(not self.hayPlantaYEsAdultaEn(posit)){
			self.error("No hay nada para cosechar")
		}
	}

	method hayPlantaYEsAdultaEn(posit){
		return self.hayPlantaEn(posit) and self.plantaEn(posit).esAdulto()
	}


}