class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def show
    @comments_class = params[:tab] && params[:tab] == "comments" ? "active" : ""
    @posts_class = params[:tab] && params[:tab] == "comments" ? "" : "active"
  end

  def new
    @user = User.new
  end

  def create
    binding.pry
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "You are registered."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Your profile was updated."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end

  def set_user
    @user = User.find_by(slug: params[:id])
  end
  
  def require_same_user
    unless current_user == @user
      redirect_to root_path, error: "Action not allowed."
    end
  end

end
