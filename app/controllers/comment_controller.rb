require 'ipaddr'

class CommentController < ApplicationController
  layout nil
  def create_comment
    user_t = UserToken.find_by_token(params[:user_token])
    site = Site.find_by_token(params[:site_token])

    unless user_t.nil? or site.nil?
      comment = Comment.new
      comment.comment = params[:text]
      comment.site = site
      comment.user_token = user_t
      comment.ip = (IPAddr.new params[:ip]).to_s
      comment.save
      render json: {"comment_id" => comment.id, "comment_cred" => comment.generate_cred}

    else

      render json: {"error" => "tokens are incorrect"}, status: 400

    end
  end

  def upvote_comment
    user_t = UserToken.find_by_token(params[:user_token])
    site = Site.find_by_token(params[:site_token])
    comment = Comment.find_by_id(params[:id])

    unless user_t.nil? or site.nil? or comment.nil?
      v = Vote.new
      v.points = user_t.user_cred
      v.user_token = user_t
      v.comment = comment
      if v.save
        render json: comment.generate_cred
      else
        render json: {"error" => "already voted"}, status: 400
      end
    else
      render json: {"error" => "incorrect parameters"}, status: 400
    end
  end

  def downvote_comment
    user_t = UserToken.find_by_token(params[:user_token])
    site = Site.find_by_token(params[:site_token])
    comment = Comment.find_by_id(params[:id])

    unless user_t.nil? or site.nil? or comment.nil?
      v = Vote.new
      v.points = 0-user_t.user_cred
      v.user_token = user_t
      v.comment = comment
      if v.save
        render json: comment.generate_cred
      else
        render json: {"error" => "already voted"}, status: 400
      end
    else
      render json: {"error" => "incorrect parameters"}, status: 400
    end
  end

  def flag_comment
    user_t = UserToken.find_by_token(params[:user_token])
    site = Site.find_by_token(params[:site_token])
    comment = Comment.find_by_id(params[:id])
    flag = Flag.find_by_id(params[:flag_id])

    unless user_t.nil? or site.nil? or comment.nil? or flag.nil?
      f = CommentFlag.new
      f.comment = comment
      f.flag = flag
      f.user_token = user_t
      f.description = params[:description]
      if f.save
        render json: comment.generate_cred
      else
        render json: {"error" => "already flagged"}, status: 400
      end
    else
      render json: {"error" => "incorrect parameters"}, status: 400
    end
  end

  def index
  end
end
