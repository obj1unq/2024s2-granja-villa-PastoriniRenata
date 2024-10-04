import wollok.game.*
import granja.*
import cultivos.*
import aspersor.*
import mercado.*

object hector {
	var property position = game.at(4,4)
	const property image = "player.png"
	var property oro = 0
	var property cosechado = #{}
	var property aspersores = []

	method mover(direccion){
		const nuevaPosition = direccion.siguiente(position)

		granja.validarDentro(nuevaPosition)

		position = nuevaPosition
	}


	method sembrarTrigo(){
		granja.validarSiPuedoPlantar(position)
		const trigo = new Trigo(position = position)
		granja.sembrar(trigo)
		game.addVisual(trigo)
		
	}
    method sembrarMaiz(){
		granja.validarSiPuedoPlantar(position)
		const maiz = new Maiz(position = position)
		granja.sembrar(maiz)
        game.addVisual(maiz)
	}
    method sembrarTomaco(){
		granja.validarSiPuedoPlantar(position)
		const tomaco = new Tomaco(position = position)
		granja.sembrar(tomaco)
		game.addVisual(tomaco)
	}

	method regar(){
		granja.regarPlantaSiHay(position)
	}


	method cosecha() {

		granja.validarSiPuedoCosechar(position) //se fija si hay una planta y si es adulta, lo hago acá para poder saber d si me lo tengo q guardar en "cosechado"

		cosechado.add(granja.plantaEn(position)) //guardo la planta en la lista d hector para dsps poder venderla
		granja.cosechar(position)
		
	}
	
	method vender(){
		//no necesito validar xq si está vacío el set no pasa nada
		granja.validarSiEstoyEnMercadoParaVender(position)
		
		granja.validarSiPuedeVenderEn(position, self.valorDeSuCosecha())
		
		granja.elMercadoCompra(position)

		oro += self.valorDeSuCosecha()
		cosechado.clear()
	
	}
	method tieneMercaderia(){
		return cosechado.size()>0
	}

	method valorDeSuCosecha(){
		return cosechado.sum({planta => planta.precio()})
	}

	method info(){
		game.say(self, "tengo "+ self.oro() + " monedas, y " + cosechado.size() + " plantas para vender. El Precio de mi cosecha es de: " + self.valorDeSuCosecha())
	}


	method agregarAspersor(){
		const regador = new Aspersor(position = position)
		granja.validarSiNoEstoyEnMercado(self.position())
		game.addVisual(regador)
		aspersores.add(regador)
	}

	method activarAspersores(){
		aspersores.forEach({aspersor => aspersor.regar()})

	}

}


