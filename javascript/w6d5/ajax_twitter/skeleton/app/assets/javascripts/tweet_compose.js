$.TweetCompose = function (el) {
  this.$el = $(el);
  // var $submit = this.$el.find('input[type=Submit]');
  this.$content = this.$el.find('textarea[name=tweet\\[content\\]]');
  this.$mentionUserIds = this.$el.find('select'); //too complicated to make the search more specific
  this.$content.on('input', this.handleInput.bind(this));
  this.$el.on('click', 'a.add-mentioned-user', this.addMentionedUser.bind(this));
  this.$el.on('click','a.remove-mentioned-user', this.removeMentionedUser.bind(this));
  this.$el.on('submit', this.submit.bind(this));
}

$.TweetCompose.prototype.removeMentionedUser = function (event) {
  event.preventDefault();
  var $currentTarget = $(event.currentTarget);
  $currentTarget.parent('div').remove();
}

$.TweetCompose.prototype.handleInput = function (event) {
  event.preventDefault();
  var chars = this.$content.val().length;
  var $charsLeft = $('.chars-left');
  $charsLeft.text(140-chars);
}

$.TweetCompose.prototype.addMentionedUser = function () {
  var $scriptTag = this.$el.find('script');
  var html = $scriptTag.html();
  $('div.mentioned-users').append(html);
}

$.TweetCompose.prototype.submit = function (event) {
  event.preventDefault();
  var formContents = this.$el.serializeJSON();
  $(':input').prop('disabled', true);
  var tweetCompose = this;
  $.ajax({
    url: '/tweets',
    method: 'post',
    data: formContents,
    dataType: 'json',
    success: function(data) {
      tweetCompose.handleSuccess(data);
    }
  })
}

$.TweetCompose.prototype.handleSuccess = function (tweet) {
var $tweetsUl = $(this.$el.data('tweets-ul'));
console.log($tweetsUl);
$tweetsUl.trigger('insert-tweet', tweet);
this.clearInput();
}

$.TweetCompose.prototype.clearInput = function () {
  this.$content.val("");
  this.$mentionUserIds.val("");
  $('div.mentioned-users').empty();
  $('.chars-left').empty();
  $(':input').prop('disabled', false);
}

$.fn.tweetCompose = function() {
  return this.each(function() {
    new $.TweetCompose(this);
  })
}

$(function () {
  $('form.tweet-compose').tweetCompose();
})
