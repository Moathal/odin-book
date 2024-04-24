class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :profile_privacy_setting, :integer
    add_column :users, :posts_privacy_setting, :integer
  end
end
