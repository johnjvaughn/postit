class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:new, :create, :edit, :update]
  before_action :require_creator_or_admin, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by{ |post| post.net_votes }.reverse
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @comment = Comment.new

    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :url, :description))
    #not sure why sending the full params to .new creates an error
    if @post.save
      @post.creator = current_user
      @post.update(post_params)  #need this workaround to save the categories (see 3 lines up)
      redirect_to posts_path, notice: "Your post was created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "Your post was updated."
    else
      render :edit
    end
  end

  def vote
    vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    respond_to do |format|
      format.html { 
        flash[:error] = "You can only vote on a post once." unless vote.valid?
        redirect_to :back
      }
      format.js {
        render js: "alert('You can only vote on a post once.')" unless vote.valid? 
      }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def require_creator_or_admin
    access_denied unless current_user == @post.creator || admin_logged_in?
  end
end
