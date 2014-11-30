class Account < ActiveRecord::Base

  belongs_to :service
  belongs_to :user

  validates_uniqueness_of :service_user_identifier, scope: :service_id
  validates_presence_of :service_id
  validates_presence_of :user_id

end
