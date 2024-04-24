class CreateSpecificUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :specific_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :specificable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
