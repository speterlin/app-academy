# Asteroids

## Overview

We'll decompose the Asteroids game into the following
classes/sourcefiles:

* `Asteroids.Util` (`lib/utils.js`)
    * Utility code, especially vector math stuff.
* `Asteroids.MovingObject` (`lib/movingObject.js`)
    * Base class for anything that moves.
    * Most important methods are `#move`, `#draw(ctx)`,
      `#isCollidedWith(otherMovingObject)`.
* `Asteroid` (`lib/asteroid.js`)
    * Spacerock. It inherits from `MovingObject`.
* `Bullet` (`lib/bullet.js`)
    * Kill spacerocks with this. Also a `MovingObject` subclass.
* `Ship` (`lib/ship.js`)
    * This is you! Another `MovingObject` subclass.
* `Game` (`lib/game.js`)
    * Holds collections of the asteroids, bullets, and your ship.
    * `#step` method calls `#move` on all the objects, and
      `#checkCollisions` checks for colliding objects.
    * `#draw(ctx)` draws the game.
    * Keeps track of dimensions of the space; wraps objects around when
      they drift off the screen.
* `GameView` (`lib/gameView.js`)
    * Stores a `Game` instance.
    * Stores a `canvas` context to draw the game into.
    * Installs key listeners to move the ship and fire bullets.
    * Installs a timer to call `Game#step`.

## A Refresher on Vectors

You'll use a lot of **vector**s in this assignment.

2D vectors have an `x` and a `y` component. A position vector has an `x`
and `y` position, while a velocity vector has a speed in the `x` and the
`y` directions.

#### Distance

To find the "distance" between two points, the formula is:

    // this is math, not JavaScript
    Dist([x_1, y_1], [x_2, y_2]) = sqrt((x_1 - x_2) ** 2 + (y_1 - y_2) ** 2)

#### Norm

A vector has a **norm**, a.k.a. **magnitude** or **length**. The norm of
a velocity vector is a speed. If `obj.vel = [3, 4]` (3 horizontal pixels
and 4 vertical pixels per unit time) then the overall speed is 5 pixels
per unit time. You can easily calculate the norm of a vector using your
distance function:

    Norm([x_1, y_1]) = Dist([0, 0], [x_1, y_1])


## Phase 0: `index.html`

Write a mostly empty HTML file for your game to run in. Open your
`index.html` in  your browser and use the browser's JavaScript console
to test your code  as you go.

## Phase I: `MovingObject` and `Asteroid`

### `MovingObject`

Write a `MovingObject` class in `lib/movingObject.js`. Namespace your
code under `window.Asteroids`.

Store key instance variables:

0. 2D `pos`ition.
0. 2D `vel`ocity.
0. `radius` (everything in the  game is a circle).
0. `color`

Rather than pass all these as separate arguments, I wrote my
`MovingObject` constructor function so that I could do like so:

```js
var mo = new Asteroids.MovingObject(
  { pos: [30, 30], vel: [10, 10], radius: 5, color: "#00FF00"}
);
```

Write a `#draw(ctx)` method. Draw a circle of the appropriate `radius`
centered at `pos`. Fill it with the appropriate `color`.

Write a `#move` method. Increment the `pos` by the `vel`.

### `Asteroids.Util`

We want to allow our classes to inherit from another. We could
monkey-patch `Function` to add an `inherits` method:

```js
Function.prototype.inherits = function (ParentClass) { ... };
```

However, monkey-patching can cause problems and should be done
judiciously. Instead, let's write an `Asteroids.Util` sub-namespace in
`lib/util.js` and add our first utility function to it as
`Asteroids.Util.inherits = function (ChildClass, ParentClass) { ... }`.

### `Asteroid`

Write an `Asteroid` class in a `lib/asteroid.js` file. This should be 
a subclass of `MovingObject`.

Pick a default `COLOR` and `RADIUS` for `Asteroid`s. I set these as
properties of the `Asteroid` class: `Asteroid.COLOR` and
`Asteroid.RADIUS`.

Write your `Asteroid` constructor so that the caller specifies the
`pos` and it will call the `MovingObject` superconstructor, setting
`color` and `radius` to the `Asteroid` defauls, and choosing a random
vector for `vel`. I wrote an `Asteroids.Util.randomVec(length)` helper
function.

```js
// Other properties are filled in for you.
new Asteroids.Asteroid({ pos: [30, 30] });
```

**NB**: There are no constants in JavaScript, but you can use
conventions like ALL_CAPS to show that certain values should not be
modified.

### `Game`

Write an `Asteroids.Game` class in `lib/game.js`. Constants I defined
on the `Game` class were `DIM_X`, `DIM_Y`, and `NUM_ASTEROIDS`.

Write a `Game#addAsteroids` method. Randomly place the asteroids
within the dimensions of the game grid. I wrote a `Game#randomPosition`
method. Store the asteroids in an instance variable array `asteroids`.
Call `#addAsteroids` in your constructor.

Write a `Game#draw(ctx)` method. It should use `clearRect` to wipe down
the entire space. Call the `#draw` method on each of the `asteroids`.

Write a `Game#moveObjects` method. It should call `#move` on each of
the `asteroids`.

### `GameView`

Define an `Asteroids.GameView` class in `lib/gameView.js`. The
`GameView` should store a `Game` and a drawing `ctx`.

Write a `GameView#start` method. It should call `setInterval` to call
`Game#moveObjects` and `Game#draw` once every 20ms, say.

### Adding a canvas to `index.html`

In the body of your HTML file, add a `<canvas id="game-canvas">` tag 
with the width and height you defined in `Game`.

At the bottom of your body, add some inline JavaScript. In it, use
`document.getElementById()` to find the canvas element. It should use
`getContext` to extract a canvas context. It should construct `Game`
and `GameView` object and call `GameView#start`.

Your asteroids should fly around :-)

## Phase IIa: Wrapping Asteroids

Currently your asteroids slide off the screen. We'd like to keep
everything within the dimensions of the game's rectangular view by
mapping opposite sides of the grid view. If an asteroid scrolls off
one side, it should reappear on the other. Write a `Game#wrap(pos)`
method, which takes a `pos` in and returns a "wrapped position".

Next, change your calls of `new Asteroids.Asteroid` to pass in the
`game` as one of the `options`. In `Asteroids.MovingObject`, store the
`game`. Update your `MovingObject#move` method to call `Game#wrap` on
`this.pos` each time.

Check that your `Asteroid`s don't all fly away, but instead wrap like
they are supposed to.

## Phase IIb: Colliding Asteroids

A big part of Asteroids is the collision of objects: ships collide
with asteroids, bullets collide with asteroids. To start, let's
implement asteroids colliding with asteroids.

Write a `MovingObject#isCollidedWith(otherObject)` method. Two circles
have collided if the distance between their center points is less than
the sum of their radii. This is why I picked circles.

Next, write a `Game#checkCollisions` that iterates through the
asteroids and `alert("COLLISION");` whenever two collide. Make
sure not to check if an asteroid collides with itself.

Write a `Game#step` method, which calls `#moveObjects` then
`#checkCollisions`. Call this in `GameView#start` instead of
`#moveObjects` directly.

**Check your work**. This shouldn't be too hard if you reduce
`Game.NUM_ASTEROIDS = 4` or so.

Last: when an asteroid crashes into another, let's remove both
asteroids. Write `Game#remove(asteroid)` and
`MovingObject#collideWith(otherObject)`. In
`MovingObject#collideWith(otherObject)`, call `Game#remove` on both
objects.

We'll change this soon, but we want to have collision and removal
logic working. **Check that when two asteroids collide, they both go
away**.

## Phase IIIa: `Ship`

In `lib/ship.js`, write an `Asteroids.Ship` class; this should be
another subclass of `MovingObject`. I defined `Ship.RADIUS` and
`Ship.COLOR` as before. I default initialize the `vel` to the zero
vector.

In your `Game` constructor, build a `Ship` object. I used
`Game#randomPosition` to place the `Ship`. Save your ship to an
instance variable.

I wrote a `Game#allObjects` method that returned the array of
`Asteroid`s + the ship. I iterated through this in `Game#draw`,
`Game#moveObjects`, and `Game#checkCollisions`

Update the `MovingObject#collideWith(otherObject)` logic. Stop removing
colliding asteroids; in fact, my `MovingObject#collideWith` was empty.
However, I wrote an override of `Asteroid#collideWith(otherObject)`: if
`otherObject instanceof Ship`, I called `Ship#relocate`. My
`Ship#relocate` method reset the `Ship`'s position to
`game.randomPosition()` and reset velocity to the zero vector.

## Phase IIIb: Moving the ship

Add a `Ship#power(impulse)`. The impulse should be added to the
current velocity of the ship.

Add a `GameView#bindKeyHandlers` method. Check out the
[`keymaster`][keymaster] library. Bind keys to call `Ship#power` on
the game's `ship`. Install the handlers on `GameView#start`.

[keymaster]: https://github.com/madrobby/keymaster

## Phase IVa: Firing `Bullet`s

Write a `Bullet` subclass of `MovingObject`. The idea is that when a
`Bullet#collideWith` an `Asteroid`, we'll remove the `Asteroid` from
the `Game`.

The key is `Ship#fireBullet`. This should:

0. Construct a new `Bullet` instance.
0. You will want to use the `Ship`s vel as the direction of travel of
   the bullet.
0. Add the bullet to an array of `Game` bullets.

`Game` should store an array of `Bullet`s just like `Asteroid`s. To
make my life easier, I wrote a `Game#add(obj)` method that added to
`this.asteroids`/`this.bullets` if `obj instanceof Asteroid`/`obj
instanceof Bullet`. I wrote a similar `Game#remove(obj)` method. This
was easier than having two methods each for `Asteroid` and `Bullet`.

Update your `Game#allObjects` as well.

Update `GameView#addKeyBindings` to bind a key to `Ship#fireBullet`.

Write the override of `Bullet#collideWith`.

## Phase V: Cleaning up objects

Your `Bullet` should not wrap like other objects. When it leaves the
visible grid, it should be removed.

I wrote a `Game#isOutOfBounds(pos)` to return `true` if an object
slips off screen.

I defined a property `MovingObject.prototype.isWrappable = true`.
However, I overrode this prototype property in `Bullet` to be false.

In `MovingObject#move`, after updating the position I check if the
object is out of bounds. If so, I either (A) wrap the object if it
`isWrappable` or (B) call `Game#remove` if not.

## Phase VI (Bonus): Drawing an image

Oftentimes people want to draw a background image on their game.

```javascript
var img = new Image();
img.onload = function () {
  ctx.drawImage(img, xOffset, yOffset);
};
img.src = 'myImage.png';
```

Note you may have to redraw the background each iteration. You do not
need to constantly reload the img; just make sure to `ctx.drawImage`
each frame.

## Resources

* [Canvas tutorial](https://developer.mozilla.org/en-US/docs/HTML/Canvas/Tutorial?redirectlocale=en-US&redirectslug=Canvas_tutorial)
* [Canvas docs](https://developer.mozilla.org/en-US/docs/HTML/Canvas)
* [Legend](http://asteroids.aaronik.com/)
* [Legend](http://asteroidsdamacy.com/)
