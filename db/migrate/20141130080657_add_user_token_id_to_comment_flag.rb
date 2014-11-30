class AddUserTokenIdToCommentFlag < ActiveRecord::Migration
  def change
    add_column :comment_flags, :user_token_id, :integer
  end
end
