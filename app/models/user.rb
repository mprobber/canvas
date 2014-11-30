require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessor :password
  has_many :accounts
  has_many :user_tokens
  before_save :prepare_password
  has_many :services, through: :accounts
  has_many :comments, through: :user_tokens
  has_many :comment_flags, through: :comments
  has_many :flags, through: :comment_flags
  has_many :votes, through: :user_tokens
  has_many :site_moderators
  has_many :sites, through: :site_moderators

  scope :needs_attention, -> {joins(:flags).distinct}
  scope :moderators, -> {joins(:site_moderators).distinct}
  scope :banned, -> {where(banned: true) }

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
    if (total_pts > 0)
      (positive_pts / total_pts) * (1.0 / (self.comment_flags.distinct.count(:comment_id) + 1.0))
    else
      (1.0 / (self.flags.distinct.count(:comment_id) + 1.0))
    end
  end

  def prepare_password
    return if password.nil?
    self.password_digest = Digest::SHA1.hexdigest(self.password)
  end

  def self.authenticate(service_id, service_user_id, pass)
    encrypted_password= Digest::SHA1.hexdigest(pass)
    puts "service_id #{service_id}, service_user #{service_user_id}"
    acct = Account.where(service_id: service_id).find_by_service_user_identifier(service_user_id)
    user = acct.user
    return user if (not user.nil?) and user.password_digest == encrypted_password
  end
end
