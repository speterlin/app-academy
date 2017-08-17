(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    this.$el.on("click", ".cell", (function (event) {
      var $square = $(event.currentTarget);
      console.log(this.game.currentPlayer)
      console.log($square);
      this.makeMove($square);
    }).bind(this));
  };

  View.prototype.makeMove = function ($square) {
    var pos = $square.data("pos");
    var currentPlayer = this.game.currentPlayer;

    $square.addClass(currentPlayer);

    try {
      this.game.playMove($square.data("pos"));
    } catch (e) {
      alert("Invalid move! try again");
      return
    }

    if (this.game.isOver()) {
      this.$el.off("click");
      this.$el.addClass("game-over");

      var winner = this.game.winner();
      var $figcaption = $("<figcaption>");

      if (winner) {
        this.$el.addClass("winner-" + winner);
        $figcaption.html("You win, "+ winner + "!");
      } else {
        $figcaption.html("It's a draw!");
      }

      this.$el.append($figcaption);
    }
  };

  View.prototype.setupBoard = function () {
    var $grid = $("<div class='grid'>");
    for (var i=0;i<3;i++) {
      var $row = $("<div class='row "+i+"'>");
      for (var j=0;j<3;j++) {
        var $cell = $("<div class='cell '></div>");
        $cell.data("pos", [i,j]);
        $row.append($cell);
      }
      $grid.append($row);
    }
    this.$el.append($grid);
  };
})();
