class CreateGroupUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :group_users do |t|
      t.integer :user_id
      t.integer :group_id
      t.timestamps
    end
    add_foreign_key :group_users, :users, column: :user_id
    add_foreign_key :group_users, :groups, column: :group_id
  end
end
