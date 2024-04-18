class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

    validate :validate_depth

  def depth
    parent ? parent.depth + 1 : 0
  end

  private

  def validate_depth
    errors.add(:base, "Depth cannot exceed 3") if depth > 3
  end
end
