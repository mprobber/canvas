class User < ActiveRecord::Base
  has_many :accounts
  has_many :services, through: :accounts
  has_many :comments
  has_many :comment_flags, through: :comments
  has_many :flags, through: :comment_flags
  has_many :votes
  has_many :site_moderators
  has_many :sites, through: :site_moderators
end
