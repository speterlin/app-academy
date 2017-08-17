(function() {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Ship = Asteroids.Ship = function (options) {
    options.radius = Ship.RADIUS;
    options.color = options.color || Ship.COLOR;
    options.vel = options.vel || [0,0];

    Asteroids.MovingObject.call(this, options);
  }

  Asteroids.Utils.inherits(Ship, Asteroids.MovingObject);

  Ship.RADIUS = 20;
  Ship.COLOR = "#FAEBD7";

  Ship.prototype.relocate = function() {
    this.pos = this.game.randomPosition();
    this.vel = [0,0];
  }

  Ship.prototype.power = function(impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
  }

  Ship.prototype.fireBullet = function() {
    var norm = Asteroids.Utils.norm(this.vel);

    if (norm == 0) {
      return;
    }

    var relVel = Asteroids.Utils.scale(
      Asteroids.Utils.dir(this.vel),
      Asteroids.Bullet.SPEED
    );

    var bulletVel = [
      relVel[0] + this.vel[0], relVel[1] + this.vel[1]
    ];

    var bullet = new Asteroids.Bullet({
      pos: this.pos,
      vel: bulletVel,
      game: this.game
    });

    this.game.add(bullet);
  }

})();
