class AddColumnsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :privacy_setting, :integer
    add_reference :posts, :shared_post, foreign_key: { to_table: :posts }
  end
end
