class Comment < ActiveRecord::Base

  has_many :comment_flags
  has_many :flags, through: :comment_flags
  belongs_to :user_token
  has_one :user, through: :user_token
  belongs_to :site
  has_many :votes

  validates_presence_of :user_token

  def get_upvotes
    positive_pts = 0
    self.votes.each do |vote|
      positive_pts += vote.points if (vote.points > 0)
    end
    positive_pts
  end

  def get_downvotes
    negative_pts = 0
    self.votes.each do |vote|
      negative_pts += vote.points if (vote.points < 0)
    end
    negative_pts.abs
  end

  def get_flags
    flags = {}
    self.comment_flags.each do |flag|
      if flags[flag.id].nil?
        flags[flag.id] = [{"description" => flag.description, "describer_cred" => flag.user_token.user_cred}]
      else
        flags[flag.id] += [{"description" => flag.description, "describer_cred" => flag.user_token.user_cred}]
      end
    end
  end
  
  def generate_cred
    #TODO make flags to spec
    puts self
    return {"user_cred_score" => self.user_token.user_cred, "upvotes" => self.get_upvotes, "downvotes" => self.get_downvotes, "flags" => self.get_flags}
  end
end
