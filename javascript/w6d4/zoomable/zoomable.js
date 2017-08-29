$.Zoomable = function (target, options) {
  this.$target = $(target);
  this.$target.addClass('zoomable');
  this.boxSize = ((options && options.boxSize) || 100);
  this.$target.on('mousemove', this.showFocusBox.bind(this));
  this.$target.on('mouseleave', this.removeFocusBox.bind(this));
}

$.Zoomable.prototype.showFocusBox = function (event) {
  if (!this.mousedOver) {
    this.mousedOver = true;
    this.$focusBox = $('<div class="focus-box"></div>');
    this.$focusBox.css('height', this.boxSize).css('width', this.boxSize)
      //  if want to make box a circle add: .css('border-radius', '50%');
    this.$target.append(this.$focusBox);

    this.offsetY = this.$target.offset().top;
    this.offsetX = this.$target.offset().left;

    var img = this.$target.find('img');
    this.imgWidth = img.innerWidth();
    this.imgHeight = img.innerHeight();
  }

  var xDiff = event.pageX - this.offsetX - (this.boxSize / 2);
  var yDiff = event.pageY - this.offsetY - (this.boxSize / 2);

  // maybe refactor, hack job to ensure box doesn't leave boundary of image
  xDiff = xDiff < 0 ? 0 : xDiff;
  xDiff = xDiff > (this.imgWidth - this.boxSize) ? (this.imgWidth - this.boxSize) : xDiff;
  yDiff = yDiff < 0 ? 0 : yDiff;
  yDiff = yDiff > (this.imgHeight - this.boxSize) ? (this.imgHeight - this.boxSize) : yDiff;

  this.$focusBox.css('left', xDiff).css('top', yDiff);
  this.showZoom(xDiff, yDiff);
}

$.Zoomable.prototype.removeFocusBox = function(event) {
  this.mousedOver = false;
  this.$focusBox.remove();

  this.zoomed = false;
};

$.Zoomable.prototype.showZoom = function (xDiff, yDiff) {
  if (!this.zoomed) {
    this.zoomed = true;

    //assuming image is square, works with rectangular images with minor errors at edges
    this.blowUpScale = this.imgWidth / this.boxSize;

    this.zoomRatio = 2;

    this.finalRatio = this.blowUpScale * this.zoomRatio;

    //needs to be refatored, hack job to ensure zoom covers entire photo by ensuring that the furthest corner point is included
    this.factorX = ((this.zoomRatio * this.imgWidth) - this.boxSize) / ((this.imgWidth - this.boxSize) * this.zoomRatio)
    this.factorY = ((this.zoomRatio * this.imgHeight) - this.boxSize) / ((this.imgHeight - this.boxSize) * this.zoomRatio)

    this.$focusBox
        .css('background-image', 'url('+this.$target.find('img').attr('src')+')')
        .css('background-size', (this.finalRatio * 100) + '% auto')
  }
  var newX = xDiff * this.zoomRatio * this.factorX;
  var newY = yDiff * this.zoomRatio * this.factorY;

  this.$focusBox.css('background-position', '-'+ newX + 'px -' + newY + 'px');
}

$.fn.zoomable = function (options) {
  this.each(function () {
    new $.Zoomable(this, options);
  });
};

$(function() {
  $('.zoomable').zoomable({ boxSize: 100 });
});
