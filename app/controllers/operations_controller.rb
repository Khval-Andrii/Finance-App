# class of OperationController
class OperationsController < ApplicationController
  before_action :set_operation, only: %i[show edit update destroy]
  before_action :categories_array, :operations_types_set, only: %i[index new show edit create update]
  before_action :authenticate_user!, except: %i[index]

  def index
    @operations = if user_signed_in?
                    fetch_operations_for_user(current_user.id, params[:page])
                  else
                    fetch_operations(params[:page])
                  end
  end

  def show; end

  def new
    @operation = current_user.operations.new(amount: 0, odate: Time.now)
  end

  def edit; end

  def create
    @operation = current_user.operations.new(operation_params)

    if @operation.save
      redirect_to operation_url(@operation), notice: 'Operation was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @operation.update(operation_params)
      redirect_to operation_url(@operation), notice: 'Operation was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @operation.destroy
    redirect_to operations_url, notice: 'Operation was successfully destroyed'
  end

  private

  def fetch_operations(page)
    store_current_page(page)
    Operation.list_of_operations.page(current_page)
  end

  def fetch_operations_for_user(user_id, page)
    store_current_page(page)
    Operation.list_of_operations(user_id).page(current_page)
  end

  def store_current_page(page)
    session[:current_page] = page if page.present?
  end

  def current_page
    session[:current_page] || 1
  end

  def operations_types_set
    @types = Operation.operations_types
  end

  def categories_array
    @categories_array = Category.categories_of_user(current_user.id).pluck(:name, :id)
  end

  def set_operation
    @operation = current_user.operations.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to operations_url, alert: 'Operation not found'
  end

  def operation_params
    params.require(:operation).permit(:amount, :odate, :description, :category_id, :types)
  end
end
