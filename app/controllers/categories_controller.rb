# class CategoriesController 
class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_category, only: %i[show edit update destroy]
  before_action :categories_types_set, only: %i[new edit create update]

  def index
    @categories = if user_signed_in?
                    fetch_categories_for_user(current_user.id, params[:page])
                  else
                    fetch_categories(params[:page])
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

  def fetch_categories_for_user(user_id, page)
    store_current_page(page)
    Category.categories_of_user(user_id).page(current_page)
  end

  def fetch_categories(page)
    store_current_page(page)
    Category.categories_of_user.page(current_page)
  end

  def store_current_page(page)
    session[:current_page] = page if page.present?
  end

  def current_page
    session[:current_page] || 1
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to categories_path, alert: 'Record not found'
  end

  def category_params
    params.require(:category).permit(:name, :description, :types)
  end

  def categories_types_set
    @types = Category.categories_types
  end
end
