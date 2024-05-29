# To deliver this notification:
#
# PostNotifier.with(record: @post).deliver(User.all)

class PostNotifier < Noticed::Event
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
    config.invalid_token = -> (device_token) {
      cleanup_device_token(token: device_token)
    }
  end

  notification_methods do
    def title_message
      message_on_type
    end

    def body_message
      params[:record].text
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

  def cleanup_device_token(token:)
    FcmDeviceToken.find_by(token: token).destroy_all
  end
end