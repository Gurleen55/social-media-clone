class RemoveFollowerIdFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :follower_id
  end
end
