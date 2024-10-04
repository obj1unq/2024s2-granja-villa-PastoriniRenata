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
        if (granja.hayPlantaEn(pos)){ //no uso validar que ya tengo en granja xq no quiero un mensaje d error cuando NO haya una planta en la posicion que intente regarsea 
            granja.plantaEn(pos).regar()
        }
    }


   

}