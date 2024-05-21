# To deliver this notification:
#
# CommentNotifier.with(record: @post, type: "comment").deliver(User.all)

class CommentNotifier < Noticed::Event
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
  required_param :type
  
  notification_methods do
    def message
      message_type
    end
    
    def url
      post_path(params[:record].post)
    end
  end
  
  def message_type
    case params[:type]
    when 'comment'
      return {
        headline: "#{params[:record].user.full_name} has commented on your post.",
        body: params[:record].text
      }
    when 'reply'
      return {
        headline: "#{params[:record].user.full_name} has replied on your comment.",
        body: params[:record].text
      }
    when 'update_comment'
      return {
        headline: "#{params[:record].user.full_name} has updated a comment on your post.",
        body: params[:record].text
      }
    when 'update_reply'
      return {
        headline: "#{params[:record].user.full_name} has updated a reply on your comment.",
        body: params[:record].text
      }
    end
  end
end
