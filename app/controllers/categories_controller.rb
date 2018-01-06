class CategoriesController < ApplicationController
  before_action :require_admin, except: [:show]

  def show
    @category = Category.find_by(slug: params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to posts_path, notice: "Category has been created."
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
