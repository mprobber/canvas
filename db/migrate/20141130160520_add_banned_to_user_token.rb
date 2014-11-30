class AddBannedToUserToken < ActiveRecord::Migration
  def change
    add_column :user_tokens, :banned, :boolean
  end
end
