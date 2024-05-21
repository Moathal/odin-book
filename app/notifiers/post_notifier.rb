# To deliver this notification:
#
# Post.with(record: @post, message: "New post").deliver(User.all)

class PostNotifier < Noticed::Event
  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :recipient_type
  notification_methods do
    def message
      message_on_type
    end

    def url
      post_path(params[:record])
    end
  end

  def message_on_type
    case params[:record].depth  
    when > 0
      "#{params[:record].user.full_name} #{params[:record].parent.user == recipient ? 'have threaded your post.' : 'has threaded a post.'}"
    else
      "#{params[:record].user.full_name} has a new post."
    end
  end

  def recipients
    if params[:record].depth > 0
      [params[:record].parent.user] + params[:record].user.friends
    else
      [params[:record].user] + params[:record].user.friends
    end
  end
end