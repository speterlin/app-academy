$.Carousel = function (el) {
  $('body').placecorgi();
  this.$el = $(el);
  this.activeIdx = 0;
  var firstImage = $($('.items li img')[this.activeIdx]);
  firstImage.addClass('active');
  this.$el.on('click','.slide-left', this.slideLeft.bind(this));
  this.$el.on('click','.slide-right', this.slideRight.bind(this));
}

$.Carousel.prototype.slideLeft = function () {
  event.preventDefault();
  this.slide(1);
}

$.Carousel.prototype.slideRight = function (event) {
  event.preventDefault();
  this.slide(-1);
}

$.Carousel.prototype.slide = function (dir) {
  var $activeItem = $($('.items li img')[this.activeIdx]);
  var nextIdx = jQuery.eq(this.activeIdx, dir);
  var $nextItem = $($('.items li img')[nextIdx]);
  var newSide, oldSide;
  if (dir == 1) {
    oldSide = "left";
    newSide = "right";
  } else {
    oldSide = "right";
    newSide = "left";
  }
  $nextItem.addClass('active ' + newSide);
  setTimeout(function() {
    $activeItem.addClass(oldSide);
    $nextItem.removeClass(newSide);
  },0);
  $activeItem.one('transitionend', (function() {
    $activeItem.removeClass('active ' + oldSide);
  }));
  this.activeIdx = nextIdx;
}

jQuery.eq = function (activeIdx, dir) {
  var totalItems = $('.items li img').size();
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
