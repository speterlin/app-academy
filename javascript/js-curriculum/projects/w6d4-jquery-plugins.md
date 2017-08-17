# jQuery Plugins!

Let's use our knowledge of jQuery to make some plugins - or
modular bits of code that we can re-use to spiff up our websites!

Look at the [live demos][live-demos] of the plugins to get an idea of
what we're building; don't look at the code yet!

[live-demos]: https://github.com/appacademy/jQueryPlugins

## Setup

For each of our plugins, create a folder and create three files for
our html, JavaScript and CSS. Let's start with:

* `tabs.html`
* `tabs.js`
* `tabs.css`

In tabs.html, include the following HTML boilerplate:

```html
<!DOCTYPE html>
<html>
  <head>
    <title>My Cool Website</title>
  </head>

  <body></body>
</html>
```

Between the head tags, include tags to require your js and css files,
as well as jQuery.

```html
<script src="./jquery-1.11.1.js"></script>
<script src="./tabs.js"></script>
<link href="./tabs.css" rel="stylesheet" type="text/css">
```

You can download the jQuery source file from
[jQuery.com](http://jquery.com/download/).

Or you can use Google's CDN to access the source code - include the
script tag that they have on their site. (A quick search for Google
jQuery CDN should get you there!)

You can also include a CSS-reset, to normalize the CSS that your
browser comes pre-installed with.

```html
<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/3.17.2/build/cssreset/cssreset-min.css">
```

In `tabs.js`, include the following code to set up our plugin:

```
$.Tabs = function (el) { ... };

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
```

Back in `tabs.html`, let's add the element that we will be calling
``#tabs` on: `<ul class='tabs'></ul>`.

And finally, add a script tag just before the `</body>` tag, where we
will run our code after the document loads:

```html
<script>
  $(function() {
    $('.tabs').tabs();
  })
</script>
```

Now we are ready to go!

# Plugin I: Corgi Tabs :dog:

It's pretty common to want to switch content out with the use of tabs.
The site we're working on today will let us tab back and forth to view
information on different types of dog breeds. Let's make a plugin that
will help us accomplish this.

**Structure:**

Create your HTML content:

* Create a `ul` with the class `tabs`.
* Below this, create a `div`, give it the id `content-tabs`.
* Give your `ul` a `data-content-tabs` attribute. It should point to
  `#content-tabs`.
* Inside of our `div#content-tabs`, make three or more `div`s to hold
  our tabs' content. Give each of these the class `tab-pane`.
* Add a `p` tag within each, and add some text about your favorite
  breeds of dog. (You might find some good
  [dog breed info here][dog-breeds]!)
* Give each of the `.tab-pane`s a unique `id` describing its
  content. Perhaps the breed of dog will do!
* Inside of our `ul.tabs`, add as many `li` tags as there are
  `tab-pane`s. Add an anchor tag (`a`) inside each one. Give each of
  these an href that points to its corresponding fragment. (These are
  the ids of our `.tab-pane` elements.) Your link should look
  something like: `<a href='javascript:void(0);' for='#chihuahua'>Chihuahua</a>`

[dog-breeds]: http://www.justdogbreeds.com/all-dog-breeds.html)

Now open your HTML file in the browser - you should see all of your
links, and all of your content!

**Swapping Panes:**

Let's make some decisions about how we're going to signal which tabs
should be displayed. We will use jQuery to give the class `active` to
the tab that we want to see. To initialize our app so that it starts
on the first tab, give the first `div.tab-pane` the class 'active.'
Also give the corresponding `a` tag the class 'active.'

To display only the active content, lets add some CSS rules. In
`tabs.css`, use selectors to add the following properties
appropriately:

* All links with the class `active` inside of something with the class
  `tabs` should have `font-weight: bold;`.
* All `div`s with the class `tab-pane` should have `display: none;`.
* All `div`s with both class `tab-pane` and class `active` should have
  `display: block;`.

Now refresh the page - you should see only the information about your
first dog breed, and its corresponding link should be bold. Let's set
up our JavaScript file so that we can see information on other breeds!

Go to `tabs.js`, and let's set up the constructor function for our
plugin.

* Our constructor function is `$.Tabs = function(el) {}`. In it, lets
  create some instance variables.
* The constructor will be passed a plain HTML element (el). Make this
  into a jQuery object and save it as `this.$el`.
* Get the location of our content using the CSS selector in
  `data-content-tabs` from `this.$el`, make it into a jQuery object,
  and save it as `this.$contentTabs`.
* Get the active tab from our content tabs - save this as an ivar,
  making sure it's a jQuery object.

Next, let's write a `Tabs#clickTab` method that we will call when our
tab links get clicked:

* Remove the class `active` from the `$activeTab`.
* Use `$(event.currentTarget)` to get the tab that we want to make
  active. Add the `active` class to the proper `div.tab-pane` and `a`
  tags. Reassign `$activeTab`.
* Don't forget to prevent the link's default action, which is a page
  refresh.
* In the contructor, set up our click event handler by calling
  `this.$el.on('click', 'a', ...)`.

Refresh the page - you should have a working tab-browser!

**Fading Out:**

Those transitions are a bit harsh though - let's make it feel a little
smoother. What I'd like to do is fade the old pane out before making
the new pane visible.

We will do this by using the `opacity` CSS attribute and a **CSS
transition**.

Let's change our `#clickTab` method. First, let's deactivate the old
tab:

* Remove the `active` class of `$activeTab` and add `transitioning`
  class. For `.transitioning`, again display block. Also set the
  `opacity: 0`. This makes your tab totally transparent: invisible.
* Also add a [`transition` CSS property][transition-css]. This will
  smoothly vary the change in a CSS attribute over a given period of
  time. Transition the opacity property over 500ms, linearly
  interpolating between the values.
* Last, when the transition is complete, we need to make the new tab
  active. Listen for the `transitionend` event; inside the callback:
    * Remove the `transitioning` class (so it is `display: none` now)
      from the old `$activeTab`.
    * Reset `$activeTab` to the new tab to display.
    * Add the `active` class to the new `$activeTab`.
* Our `transitionend` handler is only intended to be run once; use the
  `jQuery#one` method instead of `jQuery#on`. If you don't do this,
  future triggers of `transitionend` will run the callback.

You should now have nicely fading out tabs.

[transition-css]: https://developer.mozilla.org/en-US/docs/Web/Guide/CSS/Using_CSS_transitions

**Fading in:**

After the old tab fades out, let's fade in the new tab. We'll again
use `opacity` and `transition`.

Inside the `transitionend` callback, instead of just adding `active`
to the newly activated tab, we need to go through a two-step process:

* First, add both `active` and `transitioning` classes. This will
  display the element, but the `opacity` is `0`.
* Use `setTimeout` with a delay of `0` milliseconds. In the callback,
  remove the `transitioning` class.
* Add a `transition` CSS attribute to `active` to transition the
  `opacity` property.

Why do we need `setTimeout`? For the CSS transition to apply, the
element needs be:

* displayed
* have `opacity: 0`

**before** the change to the `opacity` value. By setting `active`
**and** `transitioning` first, the element meets both criteria. We
then remove `transitioning`, which triggers a change in the
`opacity` property and triggers the transition.

Check that this works. Good job! Call your TA over to check your work
once you've got your tabs transitioning.

# Plugin II: Kitten Carousel :cat:

Now we will make a plugin that, when called on a list of images, will
let you scroll through them carousel-style. Setup your three files in
the same fashion as before.

**Structure:**

The structure of our carousel will look like so:

```html
<div class="carousel">
  <div class="items">
    ...
  </div>

  <a href="javascript:void(0)" class="slide-right">Prev</a>
  <a href="javascript:void(0)" class="slide-left">Next</a>
</div>
```

The `javascript:void(0)` tells the browser not to navigate when
someone clicks the link; it will merely fire a click event. Add some
items from [placekitten][placekitten] or [placecorgi][placecorgi].

Let's begin styling this. First, fix the size of the `div.carousel`
using `height` and `width` attributes. Next, style the `div.items` to
have a `height`/`width` of `100%` so that it takes the full size of
the carousel.

Load the page. You should see that the images overflow the size of
`div.items`. We'll fix that!

[placekitten]: http://www.placekitten.com
[placecorgi]: http://placecorgi.com
[javascript-void]: http://stackoverflow.com/questions/1291942/what-does-javascriptvoid0-mean

**Swapping Images:**

Let's begin writing `$.Carousel`. As before, this should take an
`HTMLElement`, wrap it in jQuery and save it to `this.$el`.

Set an `activeIdx` instance variable to `0`. Take the first child of
`div.items` and set a class `active`. Write a CSS rule to not display
any child of `div.items` without the `active` class.

Next, add click handlers for `.slide-left` and `.slide-right`. Using
`activeIdx`, find the currently active item and remove the `active`
class. Find the previous or next item, and add `active`. I used the
`jQuery#eq` method for this. Increment the `activeIdx` appropriately.

I wrote a `#slide(dir)` method, and `#slideLeft` and `#slideRight`
called `slide(1)` and `slide(-1)` respectively.

You should now be able to click the links and swap images. Call over
your TA and impress them!

**Sliding In:**

Let's begin sliding in images; we'll do sliding out later.

We'll have two new CSS classes to use in combination with `active`:
`right` and `left`. These will position an active image to the left or
right of the carousel using `position: absolute`: use `left: 100%` to
nudge the image to the right, and `left: -100%` to nudge the image to
the left.

In your `#slide` method, in addition to `active`, add the `right` or
`left` class as necessary. Check that when you press next or prev, the
image appears to the left or right. They will not be sliding yet!

We now have to get your images to slide! There are a couple steps:

* Add rules to `.active` to `position: absolute` and set `left:
  0%`. This is necessary, because our transition will animate the
  amount we nudge from `100%` (or `-100%` to `0%`).
* Add a rule to `.active` to `transition` the `left` property over
  500ms.
* Use the trick from Tabs: add both `active` and `left` (or `right`)
  classes to the newly activated element in `#slide`. But also use
  `setTimeout` to remove the `left` or `right` class in 0ms.

Again, this trick is necessary because we must first display the item
with a `left` property set so that we can then change it and animate
the property change.

Lastly, set `overflow: hidden` on `div.items`; this will mask the
image sliding in from the left/right.

When you click next or prev, the old image should disappear
immediately, and the new image should slide in from the left or right.

**Sliding Out:**

We now have to slide out the previous image at the same time we slide
in the new one. In `#slide`, instead of removing the `active` property
from the old image, let's add `left` or `right` to move it to the
appropriate side.

You should be able to click next/prev to slide through images
now. However, note that we never remove the `active` or `left`/`right`
properties from images we slide off. This will eventually cause
problems.

Therefore, add a `transitionend` listener, again using
`jQuery#one`. When the old image has finished shifting out of the
carousel, remove the `active` and `left`/`right` classes from it.

**Durability:**

If someone rapidly hits the next or prev links while your carousel is
transitioning, the user might break it. To prevent this, I set a
`transitioning` ivar to true at the start of `#slide`. Even before
that, I check to see if `transitioning` is true, and return
immediately from `slide` if so; this prevents a second transition
while one is ongoing.

Last, I set `transitioning` back to false in the `transitionend`
callback.

[setTimeout]: http://stackoverflow.com/questions/779379/why-is-settimeoutfn-0-sometimes-useful

# Plugin III: Thumbnails

Now let's make a plugin that, when called on a list of images, will
generate a thumbnail navigation. Setup your three files in the same
fashion as before. Check out the [live demo][live-demos] to see what
we'll build.

**Structure:**

Set up your HTML like so:

```html
<div class="thumbnails">
  <div class="active"></div>

  <div class="gutter-images">
    ... img tags go here ...
  </div>
</div>
```

Let's begin writing our `$.Thumbnails` class. The first thing to do is
to display just a single photo large and put the rest of the images in
the `.gutter-images` as small thumbnails.

Choose five images to place in the gutter. Give `img` tags in the
gutter a `width` of `20%`. Give the overall `div.thumbnails` a width
of `400px`. Reload; the images should appear small.

Because of padding added around inline elements, **your images will
not all appear in one line**. Solve this by making the `img`s in the
`.gutter-images` `display: block` and `float` them. You can read more
about the problem [here][inline-block-spacing].

[inline-block-spacing]: http://css-tricks.com/fighting-the-space-between-inline-block-elements/

Next, let's display a single active image. Write a method called
`Thumbnails#activate($img)` which takes an `img` from the
`$gutterImages`, clones it, and places it in the `div.active`. In the
constructor, set an `$activeImg` ivar to the first child of
`$gutterImages`. Activate it.

In the CSS, give the `img` in the `div.active` a width of `100%` so it
fills the whole space.

Reload; your first image should appear big.

**Activating New Images:**

Next, using event delegation, add a `click` handler on the `img` tags
of the `$gutterImages` in the constructor. You should:

* Wrap the `currentTarget` in a jQuery object.
* Set `$activeImg`.
* Call `#activate`

This should swap out images now. Test.

Next, let's write the logic for `mouseenter` and `mouseleave`. Again,
use event delegation on gutter images. On a `mouseenter` event, call
`#activate` on the current image, but do not set `$activeImg`. On a
`mouseleave` event, `#activate` the `$activeImg`.

You should now be able to mouse over gutter images to look at
them. When you leave the gutter, the active image should be
restored. Call your TA over and show off your stuff.

**Limiting Gutter Size:**

Let's add the ability to list more than five elements in the
gutter. We want to have the ability to navigate between them.

First, raise the total number of images in the gutter from five to
fifteen. If you refresh; there should be three rows of images now.

To fix this, we're going to keep track of a `gutterIdx` ivar and write
a `fillGutterImages` method. In the constructor, set `gutterIdx` to
zero. Next, grab all the images in the gutter, save them to
`$images`. Finally, call `fillGutterImages`.

Let's write `fillGutterImages`. The first thing it should do is clear
out the existing gutter children. Next, it should iterate through
`this.$images`, adding each of the images from index `gutterIdx` to
`gutterIdx + 5` (noninclusive) into the `$gutterImages`.

Test this out. For testing, try setting `this.gutterIdx` to something
greater than zero.

**Navigation:**

We now want to add left and right buttons to our gutter.

The first thing to do is wrap `div.gutter-images` in a
`div.gutter`. We should add anchor tags for left and right; use `&lt;`
and `&gt;` as the contents. Assign both links a class of `nav`.

To get these new elements to fit horizontally, assign the `a.nav`
elements a width of 5% and the `.gutter-images` a width of `90%`. Set
them all to be `display: block` and `float: left` so they are happy
sitting next to each other.

Check with your TA that this is laying out properly horizontally:
**vertical layout will look weird**.

This is the ugly part. We need to center the anchor tags. To do this,
we need to use `position: absolute` on them, setting a `top: 50%` and
a `transform: translateY(-50%)`. For that to work, we need to set the
`div.gutter` to `position: relative`. We need to set the `left`
property of the right anchor to `95%` for it to be positioned properly
horizontally.

Because `position: absolute` will take the anchor tags out of the
flow, your `.gutter-images` will shift over and overlap the space
occupied by the left anchor tag. So let's apply `position: relative`
on this as well, using a `left` offset of `5%`.

We no longer care about `display: block` or `float: left` on the
anchors or `div.gutter-images`. We're not using floating to align
them; we're absolutely positioning them in just the right spots.

Things should center horizontally again, but still not vertically! In
Chrome, check the calculated height of `div.gutter`. This is zero. In
fact, `div.gutter-images` has height zero.

This is because we have floated the `img` tags in
`div.gutter-images`. Floated items do not contribute to the height of
a div. For that reason, we should use a **clearfix**. This is an empty
div that is set to `clear: both` so that it refuses to sit next to
floated items. Let's add one after the anchor tag.

This will be forced to sit on the row below the `div.gutter-images`,
increasing the size of the parent `div.gutter`. Now that this has the
proper height, the anchors should sit vertically centered.

That was hard. Give yourself a hand. Call over a TA.

**Wrapping Up**

Give your anchor a larger `font-size` and set `text-decoration: none`.

In your plugin, add a listener on `click`s to `a.nav`. Decrement or
increment `gutterIdx` and call `fillGutterImages`.

# Bonus Plugin IV: Zoomable

Take another look at a product for auction on eBay. When you zoom over
the main image, a white box should pop up around your pointer, and a
zoomed-in version of the image should show up on the right side of the
page. Let's create a plugin that will imitate this functionality.

Setup your three files just like before.

Then, in your HTML:

* Add a `div` with class 'zoomable.'
* Find a high resolution image online, and use an `img` tag to include
  it in this `div`.

We won't have a lot of CSS on this one, start with this:

* Give your `div` a fixed width. (Small is OK.) Also give it
  `position:relative;`.
* Any `img` inside of your `div.zoomable` should have 100% width.

## Part I: Focus Box

* We will use jQuery to create a 'focus box' on mouseover. Any
  `div.focus-box` within `div.zoomable` should have a thin white
  border. What other properties do you think we may use? (HINT: what
  `position` does its parent have?)

We will add a few more rules after we start our plugin. Let's first
work on getting a 'focus box' to show up when you mouse over the
image.

* Our constructor function will be passed our `div.zoomable`, save this
  in an instance variable. Also set an instance variable for the size
  of our 'focus box.'
* It should also bind mouse events to our `$el`, one each for
  `#showFocusBox` and `#removeFocusBox`.
* Write methods for `#showFocusBox`, and `#removeFocusBox`.
* `#showFocusBox` will be responsible for creating and appending our
  `div.focus-box` in the appopriate place. Save this to an ivar,
  `$focusBox`.  Give it the height and width that we assigned in the
  constructor.
    * It will be passed an 'event' object. We can get the position of
      our mouse pointer in the viewport from this.
    * Use these X and Y position values to derive the 'top' and 'left'
      properties on our `.focus-box`.
    * We will also have to make sure that `.focus-box` does not leave
      the confines of our `img`. How do we keep this constrained?
    * `#showFocusBox` will be called many times when our mouse is over
      our `img`, how do we make sure that we are only _creating_ /
      _appending_ this one time per mouse-over? What other tasks do we
      want to make sure we're not repeating unnecessarily?
* `#removeFocusBox` should call `#remove` on our `$focusBox`.

Try it out in your browser. Do you see a white box moving around when
your mouse is over the image? If not, make sure that your `.focus-box`
has `position:absolute;`. You may also use a `z-index` on both
`.zoomable` and `.focus-box` to make sure that `.focus-box` is higher
in the DOM order.

When your box moves around, is it jerky, or smooth? If it seems to
jump around, you may want to try out some different jQuery mouse
events!

Once you've got the box moving, call your TA over for a review before
moving on to zooming in.

## Part II: Zooming

You're ready for your closeup! Let's make it so that whatever is
inside of our focus box is blown up to take up the entire height of
our screen.

In our next method, we will be appending a new `div` to our
body. Let's first give it some CSS rules to follow.

* We want our `div.zoomed-image` to take up a large part of the
  screen. Make sure that its `top`, `bottom` and `right` are all set
  to 0, and that it has absolute positioning. Don't worry about
  `left`, we will modify its width on the fly. Also give it
  `background-repeat: no-repeat;`.

In your JS file, write a method `#showZoom`.

* This method should take two values: xDiff and yDiff.
* Build your `div.zoomed-image` and append it to `body`.
* Use jQuery `#css` to give it the appropriate styles:
  * We want our zoomed-in view to be a square, just like our
    `.focus-box`. Your window will be wider than it is tall, so set
    the width to the height of the viewport.
  * Add a `background-image` property. Pass it your `img`'s `src`
    attribute.
  * Determine the scale by which you need to blow up the image, pass
    this to `background-size`.
  * Give it a `background-position` property. Derive these values from
    xDiff and yDiff.

Now call `#showZoom` at the end of `#showFocusBox`, and call `#remove`
on your `div.zoomed-image` in `#removeFocusBox`. Similar to
`#showFocusBox`, make sure you are not doing unnecessary calculations
every time.

Open in browser - you should be zooming!
