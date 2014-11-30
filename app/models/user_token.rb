class UserToken < ActiveRecord::Base
  before_create :generate_token

  belongs_to :user
  has_many :comments
  has_many :comment_flags, through: :comments
  has_many :votes

  def user_cred
    if self.user
      self.user.get_cred
    else
      self.get_cred
    end
  end

  def get_cred
    total_pts = 0
    positive_pts = 0
    self.comments.each do |comment|
      comment.votes.each do |vote|
        positive_pts += vote.points if (vote.points > 0)
        total_pts += vote.points.abs
      end
    end
    
    (total_pts / positive_pts) * (1/(self.comment_flags.distinct.count(:comment_id) + 1))
  end

  private
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(token: random_token)
    end
  end
end
