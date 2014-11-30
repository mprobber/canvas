class SitesController < ApplicationController
  def new
    @site = Site.new
  end

  def create
    s = Site.new
    s.name = params[:site][:name]
    s.url = params[:site][:url]
    if s.save
      redirect_to(s)
    else
      render json: {"error" => "uh-oh"}, status: 500
    end
  end
  def show
    @site = Site.find_by_id(params[:id])
  end
end
