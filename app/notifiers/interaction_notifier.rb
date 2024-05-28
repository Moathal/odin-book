# To deliver this notification:
#
# InteractionNotifier.with(record: @reaction, message: "New post").deliver(User.all)

class InteractionNotifier < Noticed::Event
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

  notification_methods do
    if params[:record].is_a?(Reaction)
      def body_message
        "#{params[:record].user.full_name} has reacted with #{params[:record].reaction} to your post."
      end
    else
      def body_message
        "#{params[:record].user.full_name} has shared your post."
      end
    end
    
    def title_message
      "A new notification"
    end
    
    def url
      post_path(params[:record].post)
    end
  end
end
