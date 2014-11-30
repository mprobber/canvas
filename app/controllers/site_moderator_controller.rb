require 'digest/sha1'

class SiteModeratorController < ApplicationController
  before_filter :login_required, only: :create
  def create
    s = SiteModerator.new
    s.password = params[:password]
    s.site = Site.find_by_token(params[:site_token])
    s.save
  end
end
