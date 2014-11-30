class SiteModerator < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  has_many :comments
  has_many :comment_flags
end
