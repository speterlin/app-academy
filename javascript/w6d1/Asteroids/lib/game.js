(function () {
  if (typeof Asteroids === "undefined") {
    window.Asteroids = {};
  }

  var Game = Asteroids.Game = function() {
    this.asteroids = [];
    for (var i = 0; i < Game.NUM_ASTEROIDS; i++) {
      this.add(new Asteroids.Asteroid( { pos: this.randomPosition(), game: this } ));
    }
    this.ships = [];
    this.add(new Asteroids.Ship({ pos: this.randomPosition(), game: this }));
    this.bullets = [];
  }

  Game.prototype.add = function(object) {
    if (object instanceof Asteroids.Asteroid) {
      this.asteroids.push(object);
    } else if (object instanceof Asteroids.Bullet) {
      this.bullets.push(object);
    } else if (object instanceof Asteroids.Ship) {
      this.ships.push(object);
    }
  }

  Game.prototype.randomPosition = function() {
    var x = Math.round(Math.random() * Game.DIM_X);
    var y = Math.round(Math.random() * Game.DIM_Y);
    return [x,y];
  }

  Game.prototype.wrap = function(pos) {
    if (pos[0] > Game.DIM_X) {
      pos[0] = pos[0] - Game.DIM_X;
    } else if (pos[0] < 0) {
      pos[0] = pos[0] + Game.DIM_X;
    }
    if (pos[1] > Game.DIM_Y) {
      pos[1] = pos[1] - Game.DIM_Y;
    } else if (pos[1] < 0) {
      pos[1] = pos[1] + Game.DIM_Y;
    }
    return pos;
  }

  Game.prototype.isOutOfBounds = function (pos) {
    if ((pos[0] > Game.DIM_X) || (pos[0] < 0)) {
      return true;
    } else if ((pos[1] > Game.DIM_Y) || (pos[1] < 0)) {
      return true;
    } else {
      return false;
    }
  }

  Game.prototype.checkCollisions = function () {
    var allObjects = this.allObjects();
    for (var i=0; i< allObjects.length; i++) {
      for (var j=0;j<allObjects.length; j++) {
        if (i != j) {
          if (allObjects[i].isCollidedWith(allObjects[j])) {
            // alert("COLLISION");
            allObjects[i].collideWith(allObjects[j]);
            allObjects = this.allObjects();
          }
        }
      }
    }
  }

  Game.prototype.draw = function(ctx) {
    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    this.allObjects().forEach(function(object) {
      object.draw(ctx);
    });
  }

  Game.prototype.moveObjects = function() {
    this.allObjects().forEach(function(object) {
      object.move();
    });
  }

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  }

  Game.prototype.remove = function(object) {
    if (object instanceof Asteroids.Asteroid) {
      var idx = this.asteroids.indexOf(object);
      this.asteroids.splice(idx,1);
    } else if (object instanceof Asteroids.Bullet) {
      var idx = this.bullets.indexOf(object);
      this.bullets.splice(idx,1);
    } else if (object instanceof Asteroids.Ship) {
      var idx = this.ships.indexOf(object);
      this.ships.splice(idx,1);
    }
  }

  Game.prototype.allObjects = function() {
    var objects = [].concat(this.asteroids, this.bullets, this.ships);
    return objects;
  }

  Game.DIM_X = 400;
  Game.DIM_Y = 400;
  Game.NUM_ASTEROIDS = 10;

})();
