# app/models/concerns/friendship_associations.rb

module FriendshipAssociations
  extend ActiveSupport::Concern

  included do
    has_many :friendships, foreign_key: 'user_id', dependent: :destroy
    has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy

    has_many :friends, through: :friendships, source: :friend
    has_many :inverse_friends, through: :inverse_friendships, source: :user

    has_many :family, -> { where(type: Friendship.types[:family]) }, through: :friendships, source: :friend
    has_many :inverse_family, -> { where(type: Friendship.types[:family]) }, through: :inverse_friendships, source: :user

    has_many :close_friends, -> { where(type: Friendship.types[:close_friend]) }, through: :friendships, source: :friend
    has_many :inverse_close_friends, -> { where(type: Friendship.types[:close_friend]) }, through: :inverse_friendships, source: :user

    has_many :other_friends, -> { where(type: Friendship.types[:other]) }, through: :friendships, source: :friend
    has_many :inverse_other_friends, -> { where(type: Friendship.types[:other]) }, through: :inverse_friendships, source: :user
  end
end