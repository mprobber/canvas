class Site < ActiveRecord::Base
  before_create :generate_token

  has_many :site_moderators
  has_many :users, through: :site_moderators
  has_many :categories
  has_many :comments, through: :categories
  belongs_to :network

  private
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(token: random_token)
    end
  end
end
