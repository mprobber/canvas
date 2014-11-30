class Comment < ActiveRecord::Base

  has_many :comment_flags
  has_many :flags, through: :comment_flags
  belongs_to :user
  belongs_to :category
  belongs_to :site, through: :category
  has_many :votes
  
end
