# To deliver this notification:
#
# InteractionNotifier.with(record: @reaction, message: "New post").deliver(User.all)

class InteractionNotifier < Noticed::Event
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
  # required_param :type

  notification_methods do
    if params[:record].is_a?(Reaction)
      def message
        "#{params[:record].user.full_name} has reacted with #{params[:record].reaction} to your post."
      end
    else
      def message
        "#{params[:record].user.full_name} has shared your post."
      end
    end
    
    def url
      post_path(params[:record].post)
    end
  end
end
