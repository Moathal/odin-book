# app/models/concerns/friendship_associations.rb

module FriendshipAssociations
  extend ActiveSupport::Concern

  included do
    has_many :friendships_as_user1, class_name: 'Friendship', foreign_key: 'user1_id', dependent: :destroy
    has_many :friendships_as_user2, class_name: 'Friendship', foreign_key: 'user2_id', dependent: :destroy

    has_many :friends_as_user1, through: :friendships_as_user1, source: :user2
    has_many :friends_as_user2, through: :friendships_as_user2, source: :user1

    has_many :family_as_user1, -> { where(type1: Friendship.type1s[:family]) }, through: :friendships_as_user1, source: :user2
    has_many :family_as_user2, -> { where(type2: Friendship.type2s[:family]) }, through: :friendships_as_user2, source: :user1

    has_many :close_friends_as_user1, -> { where(type1: Friendship.type1s[:close_friend]) }, through: :friendships_as_user1, source: :user2
    has_many :close_friends_as_user2, -> { where(type2: Friendship.type2s[:close_friend]) }, through: :friendships_as_user2, source: :user1

    has_many :other_friends_as_user1, -> { where(type1: Friendship.type1s[:other]) }, through: :friendships_as_user1, source: :user2
    has_many :other_friends_as_user2, -> { where(type2: Friendship.type2s[:other]) }, through: :friendships_as_user2, source: :user1
  end
end