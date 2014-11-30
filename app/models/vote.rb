class Vote < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user_token
  belongs_to :user, through: :user_tokens
end
