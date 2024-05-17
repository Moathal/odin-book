class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"
  
  validates :follower_id, presence: true
  validates :followee_id, presence: true

  def became_friends
    Follow.exists?(follower_id: followee_id, followee_id: follower_id) ? Friendships.create(user1_id: follower_id, user2_id: followee_id, type1: 'other', type2: 'other') : nil
  end
end
