import wollok.game.*
import granja.*
import cultivos.*
import aspersor.*
import hector.*
class Mercado{
    var property position = null
    const property image = "market.png"
    var property oro = 100000
    var property mercaderia = #{}


    

    method compra() {
        mercaderia.addAll(hector.cosechado())
        oro -= hector.valorDeSuCosecha()

        //game.say(hector, "Mi mercaderia ahora es: " + self.mercaderia())
    }

    method tieneSuficienteDinero(precio){
        return self.oro() >= precio
    }



}

