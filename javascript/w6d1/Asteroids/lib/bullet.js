(function() {
  if (typeof Asteroids === "undefined") {
     window.Asteroids = {};
  }

  var Bullet = Asteroids.Bullet = function(options) {
    options.color = Bullet.COLOR;
    options.radius = Bullet.RADIUS;

    Asteroids.MovingObject.call(this,options);
  }

  Asteroids.Utils.inherits(Bullet, Asteroids.MovingObject);

  Bullet.COLOR = "#000000";
  Bullet.RADIUS = 2;
  Bullet.SPEED = 15;

  Bullet.prototype.isWrappable = false;

  Bullet.prototype.collideWith = function (otherObject) {
    if (otherObject instanceof Asteroids.Asteroid) {
      this.game.remove(this);
      this.game.remove(otherObject);
    }
  }

})();
