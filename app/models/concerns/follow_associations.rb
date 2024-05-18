# app/models/concerns/follow_associations.rb

module FollowAssociations
  extend ActiveSupport::Concern

  included do
    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followees, through: :followed_users, source: :followee

    has_many :follower_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :follower_users, source: :follower
  end
end