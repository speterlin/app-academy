(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  Asteroids =  {
    Utils: {
      inherits: function (ChildClass, ParentClass) {
        function Surrogate () { this.constructor = ChildClass};
        Surrogate.prototype = ParentClass.prototype;
        ChildClass.prototype = new Surrogate;
      },
      dist: function (pos1, pos2) {
        return Math.sqrt(
          Math.pow(pos1[0] - pos2[0], 2) + Math.pow(pos1[1] - pos2[1], 2)
        );
      },
      dir: function (vec) {
       var norm = Asteroids.Utils.norm(vec);
       return Asteroids.Utils.scale(vec, 1 / norm);
      },
      norm: function (vec) {
        return Asteroids.Utils.dist([0, 0], vec);
      },
      scale: function (vec, m) {
        return [vec[0] * m, vec[1] * m];
      },
      randomVec: function (length) {
        var dx = Math.round(Math.random() * length);
        var dy = Math.round(Math.random() * length);
        return [dx,dy];
      }
    }
  }
})();

//example
// var Dog = function () {this.name = "doggy"; }
// Dog.prototype.walk = function () {console.log("walking")}
// // console.log(Dog.prototype)
// var Cat = function () {this.name = "kitty"; }
// Asteroids.Utils.inherits(Cat, Dog);
// console.log(Cat.prototype)
