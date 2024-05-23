# To deliver this notification:
#
# follow = Follow.find(params[:id])
# FollowFriendshipNotifier.with(record: follow).deliver(follow.followee)

class FollowFriendshipNotifier < Noticed::Event
  deliver_by :turbo_stream, class: "DeliveryMethods::TurboStream"
  deliver_by :webpush, class: "DeliveryMethods::Webpush"

  def notification_params 
    {
      follower: params[:record].follower.full_name,
    }
  end

  notification_methods do 
    if params[:record].became_friends
      def body_message
        "#{notification_params[:follower].full_name} has followed you back. You are now friends!! "  
      end
      
      def categorize_friend
        { friendship_types: Friendship.types,
          change_friendship_type_url: :change_friendship_type_url
        }
      end
    
    else
      def body_message
        "#{notification_params[:follower].full_name} has followed you."
      end
    end
    
    def follower_url
      user_path(params[:record].follower)
    end

    def title_message
      "A new Notification"
    end
  end

  def change_friendship_type_url
      friendship = Friendship.find_by(user_id: recipient.id, friend_id: params[:record].follower.id)
    user_friendship_path(recipient, friendship, type: friendship.type)
  end
end
