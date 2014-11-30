class AddUserTokenIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :user_token_id, :integer
  end
end
