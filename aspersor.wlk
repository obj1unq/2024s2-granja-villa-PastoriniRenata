import wollok.game.*
import hector.*
import cultivos.*
import granja.*


class Aspersor{
    var property position = null
    const property image = "aspersor.png"
    const posicionesARegar = [game.at(position.x()-1, position.y()+1), game.at(position.x(),position.y()+1), game.at(position.x()+1,position.y()+1),
                              game.at(position.x()-1,position.y()),    game.at(position.x(),position.y()),   game.at(position.x()+1,position.y()),
                              game.at(position.x()-1,position.y()-1),  game.at(position.x(),position.y()-1), game.at(position.x()+1,position.y()-1)]
   
    method regar() {
        posicionesARegar.forEach({pos => self.regarLaPlanta(pos)})
    }
    method regarLaPlanta(pos){
        if (self.validarRegar(pos)){ //no uso validar dentro xq no quiero un mensaje d error cuando sea un regador en el borde e intente regar fuera del tablero
            granja.regarPlanta(pos)
        }
    }

    method validarRegar(pos){
        return granja.estaDentro(pos) and granja.hayPlantaEn(pos)  //no uso la validacion que ya existe para q no me salten errores
    }
   

}