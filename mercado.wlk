import wollok.game.*
import granja.*
import cultivos.*
import aspersor.*
import hector.*
class Mercado{
    var property position = null
    const property image = "market.png"
    var property oro = 50000
    var property mercaderia = #{}

    

    method compra() {
        mercaderia.add({hector.cosecha()})
        oro -= hector.valorDeSuCosecha()
        
    }

    method tieneSuficienteDinero(precio){
        return self.oro() >= precio
    }



}