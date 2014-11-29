class Flag < ActiveRecord::Base
  has_many :comment_flags
  belongs_to :site_moderator
end
