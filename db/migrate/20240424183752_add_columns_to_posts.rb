class AddColumnsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :privacy_setting, :integer
  end
end
