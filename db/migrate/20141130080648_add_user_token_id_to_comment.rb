class AddUserTokenIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :user_token_id, :integer
  end
end
