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
  # required_param :message

  def notification_params 
    {
      follower: params[:record].follower.fullname,
    }
  end

  notification_methods do 
    if params[:record].became_friends
      def message
        "#{notification_params[:follower].fullName} has followed you back. You are now friends!! "  
      end
      
      def type
        'new_friend'
      end
      
      def categorize_friend
        { friendship_types: Friendship.types,
          change_friendship_type_url: :change_friendship_type_url
        }
      end
    
    else
      def message
        "#{notification_params[:follower].fullName} has followed you."
      end

      def type
        'just-follow'
      end
    end
    
    def follower_url
      user_path(params[:record].follower)
    end
  end

  def change_friendship_type_url
    friendship = Friendship.find_by(user1_id: recipient.id, user2_id: params[:record].follower.id)
    if friendship
      type = friendship.type1
    else
      friendship = Friendship.find_by(user2_id: recipient.id, user1_id: params[:record].follower.id)
      type = friendship.type2
    end

    user_friendship_path(friendship, type: type)
  end
end
