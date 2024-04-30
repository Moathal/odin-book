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
      case post.user.posts_privacy_setting
      when 'posts_onlyme'
        post.user != user
      when 'posts_followers'
        !post.user.followed_by?(user)
      when 'posts_followees'
        !user.following?(post.user)
      when 'posts_specific_users'
        !post.specific_users.exists?(user_id: user.id)
      when 'posts_friends', 'close_friends', 'family', 'other'
        !user.friends_with?(post.user) || post.user.friendships.where(friend: user).first&.friendship_type != post.user.posts_privacy_setting
      else
        false
      end
    end

    cannot :read, User do |profile_user|
      blocked_by_user?(user, profile_user) || 
      case profile_user.profile_privacy_setting
      when 'profile_onlyme'
        profile_user != user
      when 'profile_followers'
        !profile_user.followed_by?(user)
      when 'profile_followees'
        !user.following?(profile_user)
      when 'profile_specific_users'
        !profile_user.specific_users.exists?(user_id: user.id)
      when 'profile_friends', 'close_friends', 'family', 'other'
        !user.friends_with?(profile_user) || profile_user.friendships.where(friend: user).first&.friendship_type != profile_user.profile_privacy_setting
      else
        false
      end
    end

    cannot :read, Post do |post|
      blocked_by_user?(user, post.user) || 
      case post.privacy_setting
      when 'onlyme'
        post.user != user
      when 'followers'
        !post.user.followed_by?(user)
      when 'followees'
        !user.following?(post.user)
      when 'specific_users'
        !post.specific_users.exists?(user_id: user.id)
      when 'friends', 'close_friends', 'family', 'other'
        !user.friends_with?(post.user) || post.user.friendships.where(friend: user).first&.friendship_type != post.privacy_setting
      else
        false
      end
    end
  end

  def blocked_by_user?(user, other_user)
    user.blocks.exists?(blocked_user_id: other_user.id) || other_user.blocks.exists?(blocked_user_id: user.id)
  end
end