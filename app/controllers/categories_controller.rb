# class CategoriesController 
class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_category, only: %i[show edit update destroy]
  before_action :categories_types_set, only: %i[new edit create update]

  def index
    if user_signed_in?
      session[:category_index_page] = params[:page] || 1
      @categories = Category.categories_of_user(current_user.id).page(session[:category_index_page])
    else
      @categories = Category.categories_of_user(0).page(params[:page])
    end
  end

  def show; end

  def new
    @category = current_user.categories.new
  end

  def edit; end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      redirect_to category_url(@category), notice: 'Category was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to category_url(@category), notice: 'Category was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to categories_path, notice: 'Record not found'
  end

  def category_params
    params.require(:category).permit(:name, :description, :types)
  end

  def categories_types_set
    @types = Category.categories_types
  end
end
