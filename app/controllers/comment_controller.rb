require 'ipaddr'

class CommentController < ApplicationController
  def create_comment
    user_t = UserToken.find_by_token(params[:user_token])
    site = Site.find_by_token(params[:site_token])
    comment = Comment.new
    comment.text = params[:text]
    comment.site = site
    comment.user_token = user_t
    comment.ip = (IPAddr.new params[:ip]).to_s
    comment.save
    render json: {"comment_id" => comment.id, "comment_cred" => comment.generate_cred}
  end

  def upvote_comment
    user_token = UserToken.find_by_token(params[:user_token])
    site = Site.find_by_token(params[:site_token])
    comment = Comment.find_by_id(params[:comment_id])

    unless user.nil? or site.nil? or comment.nil?
      v = Vote.new
      v.points = user_t.credibility_score
      v.user_token = user_token
      v.comment = comment
      v.save
      render json: comment.generate_cred
    else
      render 400
    end
  end

  def downvote_comment
    user_t = UserToken.find_by_token(params[:user_token])
    site = Site.find_by_token(params[:site_token])
    comment = Comment.find_by_id(params[:comment_id])

    unless user.nil? or site.nil? or comment.nil?
      v = Vote.new
      v.points = 0-user_t.credibility_score
      v.user_token = user_t
      v.comment = comment
      v.save
      render json: comment.generate_cred
    else
      render 400
    end
  end

  def flag_comment
    user_t = UserToken.find_by_token(params[:user_token])
    site = Site.find_by_token(params[:site_token])
    comment = Comment.find_by_id(params[:comment_id])
    flag = Flag.find_by_id(params[:flag_id])

    unless user.nil? or site.nil? or comment.nil? or flag.nil?
      f = CommentFlag.new
      f.comment = comment
      f.flag = flag
      f.user_token = user_t
      f.description = params[:description]
      f.save
      render json: comment.generate_cred
    else
      render 400
    end
  end
end
