Function.prototype.myBind = function (context) {
  var fn = this;
  var bindTimeArgs = Array.prototype.slice.call(arguments, 1);
  console.log(context, bindTimeArgs);
  var x = function () {
    var callTimeArgs = Array.prototype.slice.call(arguments);
    console.log(callTimeArgs)
    fn.apply(context, bindTimeArgs.concat(callTimeArgs));
  }
  return x;
}

function Cat () {
  this.name = "Kitty";
  this.meow = function(volume) {
    console.log(this.name +" meows "+volume);
  }
}

function Dog () {
  this.bark = function() {
    console.log("bark");
  }
  this.name = "Snozzie";
}

function Egrid () {
  this.chirp = function() {
    console.log("chirp");
  }
  this.name = "Poky";
}

function example () {
  console.log("example "+ this.name);
}

// example.apply(c);

c = new Cat;
d = new Dog;
e = new Egrid;
var func = c.meow.myBind(c,"loudly");
func();
