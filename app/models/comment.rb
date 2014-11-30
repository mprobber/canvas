class Comment < ActiveRecord::Base

  has_many :comment_flags
  has_many :flags, through: :comment_flags
  belongs_to :user_token
  belongs_to :user, through: :user_token
  belongs_to :site
  has_many :votes
  
end
