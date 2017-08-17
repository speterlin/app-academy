$.Carousel = function (el) {
  $('body').placecorgi();
  this.$el = $(el);
  console.log(this, this.$el);
  this.activeIdx = 0;
  var firstChild = $($('div.items').children()[0]);
  firstChild.addClass('active');
  this.$el.on('click','.slide-left', this.slideLeft.bind(this));
  this.$el.on('click','.slide-right', this.slideRight.bind(this));
}

$.Carousel.prototype.slideLeft = function () {
  event.preventDefault();
  this.slide(1);
}

$.Carousel.prototype.slideRight = function (event) {
  event.preventDefault();
  this.slide(-1)
}

$.Carousel.prototype.slide = function (dir) {
  var $activeItem = $($('div.items').children()[this.activeIdx]);
  var nextIdx = jQuery.eq(this.activeIdx, dir);
  var $nextItem = $($('div.items').children()[nextIdx]);
  var newSide, oldSide;
  if (dir == 1) {
    oldSide = "left";
    newSide = "right";
  } else {
    oldSide = "right";
    newSide = "left";
  }
  $nextItem.addClass('active ' + newSide);
  $activeItem.one('transitionend', (function() {
    $activeItem.removeClass('active ' + oldSide);
  }).bind(this))
  this.activeIdx = nextIdx;
  setTimeout(function() {
    $activeItem.addClass(oldSide);
    $nextItem.removeClass(newSide);
  },0);
}

jQuery.eq = function (activeIdx, dir) {
  var totalItems = $('div.items').children().size();
  var nextIdx = activeIdx + dir;
  if (nextIdx == totalItems) {
    nextIdx = 0;
  } else if (nextIdx < 0) {
    nextIdx = totalItems - 1;
  }
  return nextIdx;
}

$.fn.carousel = function() {
  return this.each(function() {
    new $.Carousel(this);
  })
}
