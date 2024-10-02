import wollok.game.*
import granja.*
import cultivos.*
import aspersor.*
import hector.*
class Mercado{
    var property position = null
    const property image = "market.png"
<<<<<<< HEAD
    var property oro = 5000
=======
    var property oro = 50000
>>>>>>> e279ec24adfbc3df12da92fe3be9e254b465d978
    var property mercaderia = #{}

    

    method compra() {
        mercaderia.add({hector.cosecha()})
        oro -= hector.valorDeSuCosecha()
        
    }

    method tieneSuficienteDinero(precio){
        return self.oro() >= precio
    }



}