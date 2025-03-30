class AddFollowerIdToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :follower_id, :integer
    add_index :users, :follower_id
    add_foreign_key :users, :users, column: :follower_id
  end
end
