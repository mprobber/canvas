class SiteNetwork < ActiveRecord::Base
  belongs_to :site
  belongs_to :network
end
