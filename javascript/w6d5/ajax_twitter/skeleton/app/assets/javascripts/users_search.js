$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find('input[name=username]');
  this.$ul = $('ul.users');
  this.$input.on('input', this.handleInput.bind(this));
}

$.UsersSearch.prototype.handleInput = function () {
  var usersSearch = this;
  $.ajax({
    method: 'get',
    url: '/users/search',
    data: {'query': this.$input.val()},
    dataType: 'json',
    success: function(data) {
      usersSearch.renderResults(data);
    }
  })
}

$.UsersSearch.prototype.renderResults = function (users) {
  console.log('rendering');
  this.$ul.empty();
  var usersSearch = this;
  users.forEach(function(user) {
    var $li = $('<li><a href="/users/'+user.id+'">'+user.username+'</a></li>');
    var $button = $('<button></button>');
    var followState = user.followed ? 'followed' : 'unfollowed'
    console.log(user, followState, $button);
    $button.followToggle({
      userId: user.id,
      followState: followState
    })
    $li.append($button);
    usersSearch.$ul.append($li);
  })
}

$.fn.usersSearch = function () {
  return this.each(function() {
    new $.UsersSearch(this);
  });
}

$(function () {
  $('div.users-search').usersSearch();
})
