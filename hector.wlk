import wollok.game.*
import granja.*
import cultivos.*


object hector {
	var property position = game.center()
	const property image = "player.png"
	var property oro = 0

	method mover(direccion){
		const nuevaPosition = direccion.siguiente(position)
		granja.validarDentro(nuevaPosition)

		position = nuevaPosition
	}


	method sembrarTrigo(){
		const trigo = new Trigo(position = self.position())
		granja.sembrar(trigo)
        game.addVisual(trigo)
	}
    method sembrarMaiz(){
		const maiz = new Maiz(position = self.position())
		granja.sembrar(maiz)
        game.addVisual(maiz)
	}
    method sembrarTomaco(){
		const tomaco = new Tomaco(position = self.position())
		granja.sembrar(tomaco)
        game.addVisual(tomaco)
	}

/*

	method sembrar(cultivo){
		const cult = new cultivo(position = self.position())
		granja.sembrar(cult)
		gameAddVisual(cult)

	}

*/
}


