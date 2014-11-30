class Site < ActiveRecord::Base
  has_many :site_moderators
  has_many :users, through: :site_moderators
  has_many :categories
  has_many :comments, through: :categories
  belongs_to :network
end
