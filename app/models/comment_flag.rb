class CommentFlag < ActiveRecord::Base

  belongs_to :comment
  belongs_to :flag
  belongs_to :user
  belongs_to :moderator

end
