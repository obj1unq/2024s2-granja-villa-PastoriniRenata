import wollok.game.*
import granja.*
import cultivos.*


object hector {
	var property position = game.at(4,4)
	const property image = "player.png"
	var property oro = 0
	var property cosechado = #{}

	method mover(direccion){
		const nuevaPosition = direccion.siguiente(position)

		granja.validarDentro(nuevaPosition)

		position = nuevaPosition
	}


	method sembrarTrigo(){
		if (not granja.hayPlantaEn(position)){
			const trigo = new Trigo(position = position)
			granja.sembrar(trigo)
			game.addVisual(trigo)
		}else{
			self.error("No puedes plantar, ya hay una planta aquí")
		}
	}
    method sembrarMaiz(){
		if (not granja.hayPlantaEn(position)){
		const maiz = new Maiz(position = position)
		granja.sembrar(maiz)
        game.addVisual(maiz)
		}else{
			self.error("No puedes plantar, ya hay una planta aquí")
		}
	}

    method sembrarTomaco(){
		if (not granja.hayPlantaEn(position)){
			const tomaco = new Tomaco(position = position)
			granja.sembrar(tomaco)
			game.addVisual(tomaco)
			}else{
			self.error("No puedes plantar, ya hay una planta aquí")
		}
	}




	method cosecha() {

		granja.validarCosecha(position) //se fija si hay una planta y si es adulta

		cosechado.add(granja.plantaEn(position)) //guardo la planta en la lista d hector para dsps poder venderla
		granja.cosechar(position)
		
	}


/*
	method sembrar(cultivo){
		const cult = new cultivo(position = position)
		granja.sembrar(cult)
		game.addVisual(cult)
	}

*/

	method regar(){
		if (granja.hayPlantaEn(position)){
				granja.crecerPlanta(position)			
			}else{
				self.error("No tengo nada para regar")
			}
	}


	method vender(){
		cosechado.forEach({planta => self.sumar(planta.precio())})
		cosechado.clear()
	}
	method sumar(monto){
		oro += monto
	}

	method info(){
		game.say(self, "tengo "+ self.oro() + " monedas, y " + cosechado.size() + " plantas para vender")
	}


}


