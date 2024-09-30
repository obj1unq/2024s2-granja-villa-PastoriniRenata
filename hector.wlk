import wollok.game.*
import granja.*
import cultivos.*


object hector {
	var property position = game.at(4,4)
	const property image = "player.png"
	var property oro = 0
	var property cocechado = #{}

	method mover(direccion){
		const nuevaPosition = direccion.siguiente(position)
		granja.validarDentro(nuevaPosition)

		position = nuevaPosition
	}


	method sembrarTrigo(){
		if (not granja.hayPlantaEn(self.position())){
			const trigo = new Trigo(position = self.position())
			granja.sembrar(trigo)
			game.addVisual(trigo)
		}else{
			self.error("No puedes plantar, ya hay una planta aquí")
		}
	}
    method sembrarMaiz(){
		if (not granja.hayPlantaEn(self.position())){
		const maiz = new Maiz(position = self.position())
		granja.sembrar(maiz)
        game.addVisual(maiz)
		}else{
			self.error("No puedes plantar, ya hay una planta aquí")
		}
	}

    method sembrarTomaco(){
		if (not granja.hayPlantaEn(self.position())){
			const tomaco = new Tomaco(position = self.position())
			granja.sembrar(tomaco)
			game.addVisual(tomaco)
			}else{
			self.error("No puedes plantar, ya hay una planta aquí")
		}
	}




	method cosecha() {
		if (not granja.hayPlantaEn(self.position())){
			self.error("No hay plantas para cosechar")
		}else{
			self.error("todavía no lo terminé")
		}
	}


/*
	method sembrar(cultivo){
		const cult = new cultivo(position = self.position())
		granja.sembrar(cult)
		game.addVisual(cult)
	}

*/

	method regar(){
		if (granja.hayPlantaEn(self.position())){
				granja.crecerPlanta(self.position())			
			}else{
				self.error("No tengo nada para regar")
			}
	}


}


