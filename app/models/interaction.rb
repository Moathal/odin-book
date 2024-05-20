class Interaction < ApplicationRecord
  belongs_to :post

  before_save :calculate_interactions_num

  def calculate_interactions_num
    self.interactions_num = (likes_num - dislikes_num) + 0.25 * (comments_num + threads_num + shares_num)
  end
end
