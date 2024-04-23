class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"
  
  validates :follower_id, presence: true
  validates :followee_id, presence: true

  def friends
    followees & followers
  end
end
