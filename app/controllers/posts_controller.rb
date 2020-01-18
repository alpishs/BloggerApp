class PostsController < ApplicationController
  before_action :require_login
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts=current_user.posts if current_user.present?
  end

  def show
  end

  def new
    @post=Post.new
  end

  def create
    @post= Post.new(post_params)
    @post.user_id = current_user.try(:id)
    redirect_to @post if @post.save
  end

  def edit
  end

  def update
    @post.update(post_params)
  end

  def destroy
    redirect_back fallback_location: root_path, notice: 'Your post is deleted!' if @post.destroy
  end

  def user
    @user = User.find( params[:user_id] )
    @posts = Post.where( user: @user ).order( created_at: :desc )
    @likes = @user.likes.joins( :post ).order( "posts.created_at DESC" )
  end

  #method for liking and disliking a particular post
  def likes
      post = Post.find( params[:post_id] )
      if like = Like.find_by( post: post, user: current_user )
        like.destroy
      else
        like = Like.new( post: post, user: current_user )
        like.save
      end
      respond_to do |format|
        format.html
        format.js
      end
      redirect_to post
  end

  private

  #allowing access to current user logged in
  def require_login
    if not Rails.env.test?
      unless current_user
        redirect_to new_user_session_path
      end
    end
  end

  #fetching and setting instance variable of @post to perform CRUD operations
  def find_post
    @post = Post.find(params[:id])
  end

  #strong parameters for post CRUD
  def post_params
    params.require(:post).permit(:title, :post_text, :avatar, :user_id).to_h
  end
end
