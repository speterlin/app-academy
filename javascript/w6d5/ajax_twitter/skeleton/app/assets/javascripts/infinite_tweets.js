$.InfiniteTweets = function (el) {
  this.$el = $(el);
  this.maxCreatedAt = null;
  this.$el.on('click', 'a.fetch-more', this.fetchTweets.bind(this));
  this.$el.on('insert-tweet', this.insertTweet.bind(this));
}

$.InfiniteTweets.prototype.fetchTweets = function (event) {
  console.log('hello');
  event.preventDefault();
  var infiniteTweets = this;
  var options = {
    url: '/feed',
    method: 'get',
    dataType: 'json',
    success: function(data) {
      infiniteTweets.insertTweets(data);
      if (data.length < 20) {
        infiniteTweets.$el.find('a.fetch-more').replaceWith('<b>No More Tweets</b>');
      }
      if (data.length > 0) {
        infiniteTweets.maxCreatedAt = data[data.length - 1].created_at
      }
    }
  }
  if (infiniteTweets.maxCreatedAt != null) {
    options.data = { 'max_created_at': this.maxCreatedAt }
  }
  $.ajax(options);
}

$.InfiniteTweets.prototype.insertTweet = function (event, tweet) {
  event.preventDefault();
  var tmpl = _.template(this.$el.find('script').html());
  this.$el.find('ul#feed').prepend(tmpl({
    tweets: [tweet]
  }));
  if (!this.maxCreatedAt) {
    this.maxCreatedAt = tweet.created_at;
  }
}

$.InfiniteTweets.prototype.insertTweets = function (tweets) {
  var tmpl = _.template(this.$el.find('script').html());
  this.$el.find('ul#feed').append(tmpl({
    tweets: tweets
  }));
}

$.fn.infiniteTweets = function() {
  return this.each(function() {
    new $.InfiniteTweets(this);
  })
}

$(function () {
  $('div.infinite-tweets').infiniteTweets();
})
