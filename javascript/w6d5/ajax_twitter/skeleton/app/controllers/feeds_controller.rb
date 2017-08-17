class FeedsController < ApplicationController
  before_action :require_logged_in!

  LIMIT = 20

  def show
    @feed_tweets =
      current_user.feed_tweets(LIMIT, params[:max_created_at]).includes(:user)
    p @feed_tweets
    respond_to do |format|
      format.html { render :show }
      format.json { render :show }
    end
  end
end
