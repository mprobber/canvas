class UserToken < ActiveRecord::Base
  before_create :generate_token

  belongs_to :user
  has_many :comments
  has_many :comment_flags, through: :comments
  has_many :flags, through: :comment_flags
  has_many :votes

  scope :banned, -> {where(banned: true) }
  scope :needs_attention, -> {joins(:flags).distinct}
  scope :none, where(:id => nil).where("id IS NOT ?", nil)

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
    if (total_pts > 0)
      (positive_pts / total_pts) * (1.0 / (self.comment_flags.distinct.count(:comment_id) + 1.0))
    else
      (1.0 / 2.0) * (1.0 / (self.comment_flags.distinct.count(:comment_id) + 1.0))
    end
  end

  def get_upvotes
    positive_pts = 0
    self.comments.each do |comment|
      comment.votes.each do |vote|
        positive_pts += vote.points if (vote.points > 0)
      end
    end
    positive_pts
  end

  def get_downvotes
    negative_pts = 0
    self.comments.each do |comment|
      comment.votes.each do |vote|
        negative_pts += vote.points if (vote.points < 0)
      end
    end
    negative_pts.abs
  end


  private
  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(token: random_token)
    end
  end
end
