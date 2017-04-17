class AddingUniqueIndexToVotes < ActiveRecord::Migration[5.0]
  def change
    add_index :votes, [:work_id, :user_id], unique: true
  end
end