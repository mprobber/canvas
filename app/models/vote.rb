class Vote < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user_token
  has_one :user, through: :user_token

  validates_uniqueness_of :user_token, scope: :comment_id
  validates_uniqueness_of :user, allow_nil: :true, scope: :comment_id
end
