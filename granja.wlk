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
    var property sembrado =  #{}

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

    
}