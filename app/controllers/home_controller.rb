class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @pagy, @news_feed = filter_posts
  end

  private

  def filter_posts
    readable_posts = Post.all.select { |post| can? :read, post }
    readable_posts.sort_by do |post|
      [
        -post.interactions.interactions_num,
        current_user.friends.exists?(post.user.id) ? 0 : 1,
        current_user.followees.exists?(post.user.id) ? 0 : 1,
        -post.created_at.to_i
      ]
    end
  end
end