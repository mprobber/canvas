class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:service_id]["id"], params[:service_user_id], params[:password])
    if user
      session[:user_token] = user.user_tokens.first.token
      puts "yay you logged in"
      render json: {"yay"=> "YAY"}, status:200
    else
      render json: {"boo"=> "BOO"}, status:400
    end
  end

  def destroy
    session[:user_token] = nil
    redirect_to home_path, notice: "You have been logged out."
  end

  private
  def current_user
    @current_user ||= UserToken.find_by_token(session[:user_token]).user if session[:user_token]
  end

  def logged_in?
    current_user
  end

  def login_required
    unless logged_in?
      render json: {"error" => "not logged in"}
    end
  end

end
