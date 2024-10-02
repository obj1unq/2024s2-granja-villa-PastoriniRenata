import wollok.game.*
import hector.*
import cultivos.*
import granja.*


class Aspersor{
    var property position = game.at(1,1)
    const property image = "aspersor.png"
    const posicionesARegar = [game.at(position.x()-1, position.y()+1), game.at(position.x(),position.y()+1),game.at(position.x()+1,position.y()+1), game.at(position.x()-1,position.y()), game.at(position.x(),position.y()),game.at(position.x(),position.y()+1),game.at(position.x()-1,position.y()-1), game.at(position.x()-1,position.y()), game.at(position.x()-1,position.y()-1)]
   
    method regar() {
        posicionesARegar.forEach({pos => self.regarLaPlanta(pos)})
    }
    method regarLaPlanta(pos){
        if (granja.estaDentro(pos)){ //no uso validar dentro xq no quiero un mensaje d error cuando sea un regador en el borde e intente regar fuera del tablero
            granja.regarPlanta(pos)
        }
    }
   

}