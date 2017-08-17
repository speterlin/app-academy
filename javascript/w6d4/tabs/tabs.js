$.Tabs = function (el) {
  $('div.tab-pane:first').addClass('active');
  var id = $('div.tab-pane:first').attr('id');
  $('a[for=#'+id+']').addClass('active');
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data('content-tabs'));
  this.$activeTab = this.$contentTabs.find('.active');
  this.$el.on('click', 'a', this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();
  this.$el.find('a').removeClass('active');
  var $newSelector = $(event.currentTarget);
  var $newTab = $('.tab-pane'+$newSelector.attr('for'));

  $newSelector.addClass('active');
  this.$activeTab.removeClass('active').addClass('transitioning');
  this.$activeTab.one("transitionend", (function() {
    console.log('transitionend');
    this.$activeTab.removeClass('transitioning');
    this.$activeTab = $newTab;
    this.$activeTab.addClass('transitioning');
    setTimeout((function() {
      this.$activeTab.removeClass("transitioning").addClass("active");
    }).bind(this),0);
  }).bind(this));
}

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
