class FlagController < ApplicationController
  def get_flags
    render json: Flag.all
  end
end
