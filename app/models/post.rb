class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :text
  has_many :comments, dependent: :destroy
  has_many :threads, class_name: 'Post', foreign_key: :parent_id, dependent: :destroy
end
