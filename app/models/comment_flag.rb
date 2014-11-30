class CommentFlag < ActiveRecord::Base

  belongs_to :comment
  belongs_to :flag
  belongs_to :user_token
  belongs_to :site_moderator

end
