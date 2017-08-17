function Cat(name, owner) {
  this.name = name;
  this.owner = owner;

}
Cat.prototype.cuteStatement = function () {
  console.log(this.owner + ' loves ' + this.name);
};

var c = new Cat("Schroder", "Leonard");
var b = new Cat("Feynman", "Shelton");
var d = new Cat("Cinnamon", "Raj");
var e = new Cat("Snaps", "Howard");
var f = new Cat("Fickle", "Penny");

c.cuteStatement();
e.cuteStatement();
f.cuteStatement();

Cat.prototype.cuteStatement = function () {
  console.log("Everyone loves " + this.name)
}

c.cuteStatement();
e.cuteStatement();
f.cuteStatement();

Cat.prototype.meow = function () {
  console.log("meow");
}

c.meow();
e.meow = function () {
  console.log(this.name + " meows");
}
e.meow();
f.meow();
