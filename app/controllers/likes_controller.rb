class LikesController < ApplicationController
  before_action :require_login

  def create
    post = Post.find( params[:post_id] )

    if like = Like.find_by( post: post, user: current_user )
      like.destroy
    else
      like = Like.new( post: post, user: current_user )
      like.save
    end

    redirect_to posts_path
  end

  private

  def require_login
    unless current_user
      redirect_to new_user_session_path
    end
  end
end
