
Function.prototype.inherits = function (SuperClass) {
  function Surrogate () {};
  Surrogate.prototype = SuperClass.prototype
  this.prototype = new Surrogate();
}



function MovingObject () {
  this.sound = "yolo";
};
MovingObject.prototype.move = function () {
  console.log('move move move');
}

m = new MovingObject();

function Ship () {
  this.name = "Shipy";
};

Ship.inherits(MovingObject);

Ship.prototype.sailing = function () {
  console.log('sailing sailing');
}

var s = new Ship()
s.sailing();
s.move();

function Asteroid () {
  this.name = "Asteroidy";
};

Asteroid.inherits(MovingObject);
var a = new Asteroid();
a.move();
