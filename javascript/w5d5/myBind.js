Function.prototype.myBind = function (context) {
  var fn = this;
  var x = function () {
    fn.apply(context)
  }
  return x;
}

function Cat () {
  this.meow = function() {
    console.log("meow");
  }
  this.name = "Newb";
}



c = new Cat;


var func = c.meow.myBind(c); //this.meow();, this set to c
func();
