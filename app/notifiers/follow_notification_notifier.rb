# To deliver this notification:
#
# follow = Follow.find(params[:id])
# FollowNotificationNotifier.with(record: follow).deliver(follow.followee)

class FollowNotificationNotifier < Noticed::Event
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
  required_param :message

  def notification_params 
    {
      follower: params[:record].follower.fullname,
    }
  end

  def ntofication_message
    "#{notification_params[:follower]} #{:message}"
  end

  def url
    follower_url(params[:record].follower)
  end
end
