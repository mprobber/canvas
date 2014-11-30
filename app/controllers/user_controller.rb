class UserController < ApplicationController
  def create_token
    t = UserToken.new
    if t.save
      render json: {"user_token" => t.token}
    else
      render 500
    end
  end

  def verify_user
    service = Service.find_by_id(params[:service_id])
    site = Site.find_by_token(params[:site_token])
    old_user_token = UserToken.find_by_token(params[:user_token])
    unless service.nil? or site.nil? or old_user_token.nil?
      account = service.accounts.find_by_service_user_id(params[:service_user_id])
      if account.nil?
        account = Account.new
        account.service = service
        #TODO if the UserToken is already associated with a user - do we join it to that user? doing that for now
        old_user_token.user = User.new if old_user_token.user.nil?
        old_user_token.user.save
        account.user = old_user_token.user
        account.save
        render json: {"user_token" => t.token}
      else
        old_user_token.user = account.user
        old_user_token.save
      end
    end
  end
  
end
