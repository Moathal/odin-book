# To deliver this notification:
#
# CommentNotifier.with(record: @post, type: "comment").deliver(User.all)

class CommentNotifier < Noticed::Event
  deliver_by :turbo_stream, class: "DeliveryMethods::TurboStream"
  deliver_by :webpush, class: "DeliveryMethods::Webpush"

  deliver_by :fcm do |config|
    config.credentials = "config/certs/fcm.json"
    config.device_tokens = -> { recipient.fcm_device_tokens.pluck(:token) }
    config.json = ->(device_token) {
      {
        message: {
          token: device_token,
          notification: {
            title: title_message,
            body: body_message,
            url: url
          }
        }
      }
    }

  required_param :type
  
  notification_methods do
    def title_message
      message_type
    end

    def body_message
      params[:record].text
    end
    
    def url
      post_path(params[:record].post)
    end
  end
  
  def message_type
    case params[:type]
    when 'comment'
      return {
        "#{params[:record].user.full_name} has commented on your post.",
      }
    when 'reply'
      return {
        "#{params[:record].user.full_name} has replied on your comment.",
      }
    when 'update_comment'
      return {
        "#{params[:record].user.full_name} has updated a comment on your post.",
      }
    when 'update_reply'
      return {
        "#{params[:record].user.full_name} has updated a reply on your comment.",
      }
    end
  end
end
