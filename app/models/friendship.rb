class Friendship < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'

  belongs_to :user

  enum type1: { close_friend: 0, family: 1, other: 2 }
  enum type2: { close_friend: 0, family: 1, other: 2 }
end
