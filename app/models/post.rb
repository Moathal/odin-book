class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :text
  has_many :comments, dependent: :destroy
  belongs_to :parent, class_name: 'Post', optional: true
  has_many :threads, class_name: 'Post', foreign_key: :parent_id, dependent: :destroy

  has_many :specific_users, as: :specificable
  has_many :users, through: :specific_users

  def depth
    parent ? parent.depth + 1 : 0
  end
end
