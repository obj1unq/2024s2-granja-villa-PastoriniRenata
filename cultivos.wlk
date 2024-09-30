import wollok.game.*
import hector.*

class Maiz {
	var position = game.at(1, 1)
	var image = "corn_baby.png"
	
	method position(){
		return position
	}
	method position(_pos){
		position = _pos
	}
	method image(){
		return image
	}
	method image(_image){
		image = _image
	}


}
class Trigo {
	var position = game.at(1, 1)
	var image =  "wheat_0.png"

	method position(){
		return position
	}
	method position(_pos){
		position = _pos
	}

	method image(){
		return image
	}
	method image(_image){
		image = _image
	}
}

class Tomaco {
	var position = game.at(1, 1)
	var image =  "tomaco_baby.png"

	method position(){
		return position
	}
	method position(_pos){
		position = _pos
	}
	method image(){
		return image
	}
	method image(_image){
		image = _image
	}
	
}


