$.Zoomable = function (target, options) {
  this.$target = $(target);
  this.$target.addClass('zoomable');
  this.boxSize = ((options && options.boxSize) || 100);
  this.$target.on('mousemove', this.showFocusBox.bind(this));
  // this.$target.on('mouseleave', this.removeFocusBox.bind(this));
}

$.Zoomable.prototype.showFocusBox = function (event) {
  if (!this.mousedOver) {
    this.mousedOver = true;
    this.$focusBox = $('<div class="focus-box"></div>');
    this.$focusBox.css('height', this.boxSize).css('width', this.boxSize);
    this.$target.append(this.$focusBox);

    this.offsetY = this.$target.offset().top;
    this.offsetX = this.$target.offset().left;

    var img = this.$target.find('img');
    this.imgWidth = img.innerWidth();
    this.imgHeight = img.innerHeight();
    console.log("img dimensions (x,y):"+this.imgWidth, this.imgHeight);
  }

  var xDiff = event.pageX - this.offsetX - (this.boxSize / 2);
  var yDiff = event.pageY - this.offsetY - (this.boxSize / 2);
  console.log("diffs (x,y)"+xDiff, yDiff);

  if (xDiff < 0) {
    xDiff = 0;
  }
  if (yDiff < 0) {
    yDiff = 0;
  }

  if (xDiff > this.imgWidth - this.boxSize / 2) {
    xDiff = this.imgWidth - this.boxSize / 2;
  }
  if (yDiff > this.imgHeight - this.boxSize / 2) {
    yDiff = this.imgHeight - this.boxSize / 2;
  }

  this.$focusBox.css('left', xDiff).css('top', yDiff);
  this.showZoom(xDiff, yDiff);
}

$.Zoomable.prototype.removeFocusBox = function(event) {
  this.mousedOver = false;
  this.$focusBox.remove();

  this.zoomed = false;
  // this.$zoom.remove();
};

$.Zoomable.prototype.showZoom = function (xDiff, yDiff) {
  if (!this.zoomed) {
    this.zoomed = true;
    this.windowHeight = window.innerHeight;
    console.log(this.windowHeight, this.imgWidth);

    //% of Image size
    this.blowUpScale = (this.imgWidth * 2 / this.boxSize) * 100;
    console.log('blowUpScale: ' + this.blowUpScale);
    // this.$zoom = $('<div class="zoomed-image"></div>');
    // this.$zoom
    //   .css('background-image', 'url('+this.$target.find('img').attr('src')+')')
    //   .css('width', this.windowHeight)
    //   .css('background-size', this.blowUpScale + '% auto')
    this.$focusBox
        .css('background-image', 'url('+this.$target.find('img').attr('src')+')')
        .css('background-size', this.blowUpScale + '% auto')

    $('body').append(this.$zoom);
  }
  console.log(this.blowUpScale, xDiff, this.imgWidth);
  //calculations assume that image is square
  xDiff = ((this.blowUpScale * xDiff) / this.imgWidth);
  yDiff = ((this.blowUpScale * yDiff) / this.imgWidth);
  console.log('new diffs(x,y)', xDiff, yDiff)
  //img sized compared to window size
  // var ratio = 2;
  // this.$zoom.css('background-position', '-'+ xDiff + 'px -' + yDiff + 'px');
  this.$focusBox.css('background-position', '-'+ xDiff + 'px -' + yDiff + 'px');
}

$.fn.zoomable = function (options) {
  this.each(function () {
    new $.Zoomable(this, options);
  });
};

$(function() {
  $('.zoomable').zoomable({ boxSize: 100 });
});
