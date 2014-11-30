class User < ActiveRecord::Base
  has_many :accounts
  has_many :user_tokens
  has_many :services, through: :accounts
  has_many :comments, through: :user_tokens
  has_many :comment_flags, through: :comments
  has_many :flags, through: :comment_flags
  has_many :votes, through: :user_tokens
  has_many :site_moderators
  has_many :sites, through: :site_moderators

  def get_cred
    total_pts = 0
    positive_pts = 0
    self.user_tokens.each do |user_token|
      user_token.comments.each do |comment|
        comment.votes.each do |vote|
          positive_pts += vote.points if (vote.points > 0)
          total_pts += vote.points.abs
        end 
      end
    end
    (total_pts / positive_pts) * (1 / (self.comment_flags.distinct.count(:comment_id) + 1))
  end
end
