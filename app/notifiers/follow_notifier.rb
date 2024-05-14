# To deliver this notification:
#
FollowNotifier.with(follow: @follow).deliver(@follow.followee)

class FollowNotifier < Noticed::Event
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
  required_param :follow

  def params 
    {
      follower: params[:follow].follower.fullname,
      followed_at: Time.current
    }
  end

  def message
    "#{params[:follow].follower.fullname} started following you"
  end
end
