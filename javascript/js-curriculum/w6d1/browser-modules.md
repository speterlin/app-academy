## Using Modules in the Browser

When writing for Node, we used `module.exports` and `require` to break our code
into modules. We can't do this in the browser; instead, our HTML document needs
to list every JavaScript library to load. Since JavaScript code is loaded in the
order the libraries are listed, if `cat.js` requires `animal.js` to be
loaded first, then the HTML document must list `animal.js` before
`cat.js`.

```html
<html>
<head>
...
</head>

<body>
...

<script src="./animal.js"></script>
<script src="./cat.js"></script>
<script src="app.js"></script>
</body>
</head>
```

Unlike Node, where each file has its own global namespace, in the browser a
global namespace (accessible as `window`), is shared across all JavaScript
files. If `animal.js` loads before `cat.js`, and
`animal.js` sets `window.Animal`, then when `cat.js` executes, it can
use `window.Animal`.

This is a little more like Ruby than Node in that there is a shared
global across all the source files. However, since the browser doesn't
have `require` built-in, JavaScript files intended for the browser
don't have the ability to load their dependencies in any standard
way; it is up to you to make sure files are loaded in the correct order.

## Immediately Invoked Function Expression (IIFE)

Here's a typical approach to writing a source file intended for
execution by the browser.

```js
// ./zoo/animal.js
(function () {
  // If window.Zoo does not exist yet, set it to a new blank object.
  if (typeof Zoo === "undefined") {
    window.Zoo = {};
  }

  // Define an Animal class; export it as `window.Zoo.Animal`. Save it
  // to a local variable named `Animal` so we can don't have to repeat
  // `Zoo.Animal.prototype` throughout `./zoo/animal.js`.
  var Animal = Zoo.Animal = function () {
    // ...
  };

  Animal.prototype.eat = function () {
    // ...
  };
})();

// ./zoo/lion.js
(function () {
  if (typeof Zoo === "undefined") {
    window.Zoo = {};
  }

  var Lion = Zoo.Lion = function () {
    // ...
  };

  // Inherit Lion from Animal
  function Surrogate () {};
  Surrogate.prototype = Animal.prototype;
  Lion.prototype = new Surrogate();

  Lion.prototype.roar = function () {
    // ...
  };
})();

// ./app.js
(function () {
  for (var i = 0; i < 10; i++) {
    console.log(new Zoo.Lion());
  }
})();
```

A couple things are happening here:

**First**, each source file consists of all the code written in an
anonymous function, which is immediately evaluated; this is called an
**Immediately Invoked Function Expression** (**IIFE**). This is done to
allow for private variables. Look at the `lion.js` file: it defines a
`Surrogate` to setup the inheritance. But because `Surrogate` is
defined as a local variable of the function, it is not available to
the outside world. We say that `Surrogate` is **private** to the
source file.

**Second**, `lion.js` "exports" the `Lion` class by making it a
property of `window.Zoo`. `Zoo` is set at the global level (`window`),
so subsequent JavaScript file can access `window.Zoo.Lion` (`Zoo.Lion`
for short). So, as long as it runs after `lion.js`, `app.js` can create
and log new lions to its heart's content.

**Third**, by **only** exporting the Zoo object, we protect the global namespace
from pollution and name collisions. This allows us to mix in libraries with
less fear and makes our code safer for other programmers to include.

The IIFE pattern allows us to export objects to the browser while protecting
the global namespace from pollution; ideally, our library should export a
single object to the window, with properties corresponding to sub-namespaces
and subclasses if the library needs them.

## Resources

* [Immediately-invoked Function Expression][iife-wiki]

[iife-wiki]: http://en.wikipedia.org/wiki/Immediately-invoked_function_expression
