(function () {
  if (typeof Asteroids === "undefined") {
     window.Asteroids = {};
  }

  var MovingObject = Asteroids.MovingObject = function (options) {
    this.pos = options.pos;
    this.vel = options.vel;
    this.radius = options.radius;
    this.color = options.color;
    this.game = options.game;
  };

  MovingObject.prototype.isWrappable = true;

  MovingObject.prototype.draw = function (ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
      this.pos[0], //X value of pos
      this.pos[1], //Y value of pos
      this.radius,
      0,
      2 * Math.PI,
      false
    );

    ctx.fill();
  }

  MovingObject.prototype.move = function () {
    this.pos = [this.pos[0] + this.vel[0], this.pos[1] + this.vel[1]];
    if (this.game.isOutOfBounds(this.pos)) {
      if (this.isWrappable) {
        this.game.wrap(this.pos);
      } else {
        this.game.remove(this);
      }
    }
  }


  MovingObject.prototype.isCollidedWith = function(otherObject) {
    var dx = Math.abs(this.pos[0] - otherObject.pos[0]);
    var dy = Math.abs(this.pos[1] - otherObject.pos[1]);
    var sumRadii = this.radius + otherObject.radius;
    if (dx < sumRadii && dy < sumRadii) {
      return true;
    } else {
      return false;
    }
  };

  MovingObject.prototype.collideWith = function(otherObject) {
    // if (otherObject instanceof Asteroids.Ship) {
    //   otherObject.relocate();
    // } else {
    //   this.game.remove(this);
    //   this.game.remove(otherObject);
    // }
  };

})();


// var mo = new Asteroids.MovingObject(
//   { pos: [30, 30], vel: [10, 10], radius: 5, color: "#00FF00"}
// );
