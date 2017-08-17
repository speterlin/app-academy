# Towers of Hanoi and TicTacToe

## Towers of Hanoi

Let's rewrite the towers of Hanoi game we previously wrote in Ruby.
[Here's][ruby-hanoi] a link to the old instructions.

Write a `HanoiGame` class:

* In the initialization, set an ivar for the stacks.
* Write an `#isWon` method that checks the stacks to see if all discs
  were moved to a new stack.
* Write an `#isValidMove(startTowerIdx, endTowerIdx)` method that
  checks that you can move the top of `startTowerIdx` onto the top of
  `endTowerIdx`.
* Write a `#move(startTowerIdx, endTowerIdx)` method that only performs
  the move if it is valid. Return true/false to indicate whether the
  move was performed.
* Write a `#print` method to print the stacks. I used `JSON.stringify`
  to turn the array of stacks to a string. This works sort of like
  Ruby's `#inspect` method (called by the Ruby `p` method).
* Write a `#promptMove(callback)` method that (1) prints the stacks,
  and (2) asks the user where they want to move a disc to/from. Pass
  the `startTowerIdx` and `endTowerIdx` to the `callback`.
* Write a `#run(completionCallback)` method.
    * `promptMove` from the user.
    * In the callback, try to perform the move. If it fails, print an
      error message.
    * If the game is not yet won, call `#run` again.
    * Otherwise, log that the user has won, then call the
      `completionCallback`.

Instantiate the `HanoiGame` class and play a game. In the completion
callback, close your `reader` so that Node knows it can exit when the
game is over.

[ruby-hanoi]: https://github.com/appacademy/ruby-curriculum/blob/master/w1d1/data-structures/array.md#towers-of-hanoi

# Tic Tac Toe

[Here's][ruby-ttt] a link to the old instructions for Tic Tac Toe.

* Write a `Board` class in `ttt/board.js`.
    * There should be no UI in your `Board`, except maybe to
      `console.log` a representation of the grid.
* Write a `Game` class in `ttt/game.js`. You'll want to require your
  `ttt/board.js` file.
    * Write the `Game` constructor such that it takes a reader interface
      as an argument. As in the previous exercise, write a
      `#run(completionCallback)` method.
* Write a `ttt/index.js` that exports both the `Game` and `Board`
  classes.
* Write a `playTicTacToe.js` script. Require the `t3` library in it.
    * Instantiate a reader.
    * Instantiate a `TTT.Game`, passing the reader.
    * Run the game; close the reader when done.

[ruby-ttt]: https://github.com/appacademy/ruby-curriculum/blob/master/w1d2/classes.md#tic-tac-toe
