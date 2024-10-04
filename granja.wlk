import wollok.game.*
import hector.*
import cultivos.*
import mercado.*

object granja {
	var property sembrado = #{}
	// #{new Trigo(position=game.at(1,0)), new Trigo(position=game.at(1,1)),new Trigo(position=game.at(1,2)),new Trigo(position=game.at(1,3)), new Trigo(position=game.at(1,4)),new Trigo(position=game.at(1,5)),new Trigo(position=game.at(1,6)),new Trigo(position=game.at(1,7))}
	var property mercados = #{}
	
	method validarDentro(posicion) {
		if (not self.estaDentro(posicion)) hector.error(
				"No puedo moverme fuera del tablero"
			)
	}
	
	method estaDentro(posicion) = posicion.x().between(
		0,
		game.width() - 1
	) and posicion.y().between(0, game.height() - 1)
	
	method sembrar(planta) {
		sembrado.add(planta)
	}
	
	method validarSiPuedoPlantar(posit) {
		if (self.hayPlantaEn(posit)) {
			hector.error("No puedes plantar, ya hay una planta aquí")
		} else {
			if (self.hayMercado(posit)) hector.error(
					"No puedes plantar, hay un mercado aquí"
				)
		}
	}
	
	method hayPlantaEn(pos) = sembrado.any(
		{ cultivo => cultivo.position() == pos }
	)
	
	method hayMercado(posit) = (posit == game.at(0, 0)) or (posit == game.at(9, 9))
	
	method agregarMercados() {
		const mercado1 = new Mercado(position = game.at(0, 0))
		const mercado2 = new Mercado(position = game.at(9, 9))
		
		mercados.add(mercado1)
		mercados.add(mercado2)
		
		game.addVisual(mercado1)
		game.addVisual(mercado2)
	}
	
	method mercadoEn(pos) = mercados.find({ mercado => mercado.position() == pos })
	
	method validarSiEstoyEnMercadoParaVender(pos) {
		if (not self.hayMercado(pos)) hector.error(
				"No puedo vender, no estoy en un mercado"
			)
	}
	
	method validarSiNoEstoyEnMercado(pos) {
		if (self.hayMercado(pos)) hector.error(
				"No puedo poner aspersor, hay un mercado"
			)
	}
	
	method validarSiPuedeVenderEn(pos, valor) {
		//ya se q tengo un mercado en esa pos!!
		if (not self.mercadoEn(pos).tieneSuficienteDinero(valor)) {
			hector.error("No puede vender, el mercado no tiene suficiente dinero")
		} else {
			if (not hector.tieneMercaderia()) hector.error(
					"No tengo mercancia que vender"
				)
			else game.say(hector, "Venta realizada!")
		}
	}
	
	method elMercadoCompra(pos) {
		self.mercadoEn(pos).compra()
	}
	
	method campoSinPlantaEn(_position) = sembrado.filter(
		{ planta => not (planta.position() == _position) }
	)
	
	method regarPlantaSiHay(_position) {
		self.validarRegar(_position) //valida si hay planta en la posicion
		self.plantaEn(_position).regar() //le digo al objeto q se riegue
	}
	
	method validarRegar(posit) {
		if (not self.hayPlantaEn(posit)) hector.error("No hay nada para regar")
	}
	
	method plantaEn(_position) = sembrado.find(
		{ planta => planta.position() == _position }
	)


/* Idea flashera (q funciona): para q siempre tenga chance d moverse al regarlo. PERO NO ES LO QUE PIDE EL README	
	method primeraPosicionLibreEnColumna(posicion) {
		// Si la posición está dentro de los límites
		if (self.estaDentro(posicion)) {
			// Si hay una planta en la posición, buscar en la siguiente
			if (self.hayPlantaEn(posicion)) {
				return self.primeraPosicionLibreEnColumna(
					game.at(posicion.x(), posicion.y() + 1)
				)
			} else {
				// Si no hay planta, devolver la posición actual
				return posicion
			}
		} else {
			// Si está fuera de los límites, reiniciar la búsqueda desde la parte superior
			return self.primeraPosicionLibreEnColumna(game.at(posicion.x(), 0))
		}
	}
*/

	method siguientePosicionSiEstaLibre(posicion) {
		// Si la posición está dentro de los límites y no hay planta
		return if (not self.estaDentro(posicion.up(1))) {
				game.at(posicion.x(), 0)
		}else if(self.hayPlantaEn(posicion.up(1))){
				posicion
		}else{
				posicion.up(1)
		}
	}
		
	method cosechar(posit) {
		//ya se q hay una planta en la posicion pasada por parametro y q es adulta!
		const plantaEnPosition = sembrado.find({ planta => planta.position() == posit })
		
		game.removeVisual(plantaEnPosition)
		
		sembrado.remove(plantaEnPosition)		//saco la planta 
	}
	
	method validarSiPuedoCosechar(posit) {
		if (not self.hayPlantaYEsAdultaEn(posit)) hector.error("No hay nada para cosechar")
	}
	
	method hayPlantaYEsAdultaEn(posit) = self.hayPlantaEn(posit) and self.plantaEn(posit).esAdulto()
}