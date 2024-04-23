# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, :all
    can :create, Post
    can :update, Post, user_id: user.id
    can :destroy, Post, user_id: user.id
    can [:create, :destroy], Follow, follower_id: user.id

    cannot :read, Post do |post|
      case post.user.privacy_setting
      when 'followers'
        !post.user.followed_by?(user)
      when 'followees'
        !user.following?(post.user)
      when 'friends'
        !user.friends_with?(post.user)
      when 'specific_users'
        !post.user.specific_users.include?(user.id)
      when 'everyone'
        false
      else
        true
      end
    end

  cannot :read, User do |profile_user|
      case profile_user.profile_privacy_setting
      when 'followers'
        !profile_user.followed_by?(user)
      when 'followees'
        !user.following?(profile_user)
      when 'friends'
        !user.friends_with?(profile_user)
      when 'specific_users'
        !profile_user.profile_specific_users.include?(user.id)
      when 'everyone'
        false
      else
        true
      end
    end
  end
end
