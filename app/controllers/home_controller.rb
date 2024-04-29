class HomeController < ApplicationController
  def index
    @pagy, @news_feed = filter_posts
  end

  private

  def filter_posts
    readable_posts = Post.accessible_by(current_ability)
    sorted_posts = readable_posts.sort_by do |post|
      [
        -post.interactions.interactions_num,
        current_user.friends.exists?(post.user.id) ? 0 : 1,
        current_user.followees.exists?(post.user.id) ? 0 : 1,
        -post.created_at.to_i
      ]
  end
end