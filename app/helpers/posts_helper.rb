module PostsHelper
  def serialized_posts
    @posts.map do |post|
      puts post.as_json.merge(text: post.text.to_trix_html)
    end
  end
end
