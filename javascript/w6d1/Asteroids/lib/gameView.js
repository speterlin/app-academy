(function() {
  if (typeof Asteroids === "undefined") {
     window.Asteroids = {};
  }

  var GameView = Asteroids.GameView = function(game, ctx) {
    this.game = game;
    this.ctx = ctx;
  }

  GameView.prototype.start = function() {
    this.bindKeyHandlers();
    setInterval(function() {
      this.game.draw(this.ctx);
      this.game.step();
    }, 20);
  }

  GameView.MOVES = {
    "up": [ 0, -1],
    "left": [-1,  0],
    "down": [ 0,  1],
    "right": [ 1,  0],
  };

  GameView.prototype.bindKeyHandlers = function() {
    var ship = this.game.ships[0];
    Object.keys(GameView.MOVES).forEach(function (k) {
      var move = GameView.MOVES[k];
      key(k, function () { ship.power(move); });
    });

    key('space', function(){
      ship.fireBullet()
    })
  }

})();
