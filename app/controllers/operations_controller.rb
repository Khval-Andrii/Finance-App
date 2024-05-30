# class of OperationController
class OperationsController < ApplicationController
  before_action :set_operation, only: %i[show edit update destroy]
  before_action :categories_array, only: %i[new edit create update]
  before_action :authenticate_user!, only: %i[show new edit create update destroy]

  def index
    @operations = Operation.page(params[:page])
  end

  def show; end

  def new
    @operation = Operation.new
  end

  def edit; end

  def create
    @operation = Operation.new(operation_params)

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

  def categories_array
    @categories_array = Category.pluck(:name, :id)
  end

  def set_operation
    @operation = Operation.find(params[:id])
  end

  def operation_params
    params.require(:operation).permit(:amount, :odate, :description, :category_id, :types)
  end
end
