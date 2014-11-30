class Network < ActiveRecord::Base
  has_many :site_networks
  has_many :sites, through: :site_networks
end
