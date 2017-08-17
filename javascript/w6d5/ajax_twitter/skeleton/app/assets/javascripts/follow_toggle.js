$.FollowToggle = function (el, options) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id") || options.userId;
  this.followState = this.$el.data("initial-follow-state") || options.followState;
  console.log(this.userId, this.followState);
  this.render();
  this.$el.on('click', this.handleClick.bind(this))
};

$.FollowToggle.prototype.render = function () {
  if (this.followState == "unfollowed") {
    this.$el.prop("disabled", false);
    this.$el.html("Follow!");
  } else if (this.followState == "followed") {
    this.$el.prop("disabled", false);
    this.$el.html("Unfollow!");
  } else if (this.followState == "following") {
    this.$el.prop("disabled", true);
    this.$el.html("Following!");
  } else if (this.followState == "unfollowing") {
    this.$el.prop("disabled", true);
    this.$el.html("Unfollowing!");
  }
}

$.FollowToggle.prototype.handleClick = function(event) {
  event.preventDefault();
  var followToggle = this;
  if (this.followState == 'unfollowed') {
    this.followState = 'following';
    this.render();
    $.ajax({
      method: 'post',
      url: '/users/'+this.userId+'/follow',
      dataType: 'json',
      success: function (data) {
        console.log(data);
        followToggle.followState = 'followed';
        followToggle.render();
      },
      error: function(status, err, data) {
        console.log(status, err, data);
      }
    });
  } else {
    this.followState = 'unfollowing';
    this.render();
    $.ajax({
      method: 'delete',
      url: '/users/'+this.userId+'/follow',
      dataType: 'json',
      success: function(data) {
        console.log(data);
        followToggle.followState = 'unfollowed';
        followToggle.render();
      }
    })
  }
}

$.FollowToggle.prototype.method1 = function () {
  // ...
};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
