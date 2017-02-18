class AddFollowingToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :following, :jsonb, null: false, default: {users: []}
  end
end
