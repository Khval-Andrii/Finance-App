# class ReportsController
class ReportsController < ApplicationController
  before_action :authenticate_user!, only: %i[index]

  def index; end

  def report_by_category
    @categories_and_amount = Operation.model_report_by_category(
      current_user.id,
      params[:start_date],
      params[:end_date],
      params[:type_operations]
    )

    @amounts = @categories_and_amount.values

    @category_names = @categories_and_amount.keys
  end

  def report_by_dates
    @dates_and_amounts = Operation.model_report_by_dates(
      current_user.id,
      params[:start_date],
      params[:end_date],
      params[:category_id]
    )

    @dates = @dates_and_amounts.keys.map { |date| date.to_date.to_s }

    @amounts = @dates_and_amounts.values.map { |amount| amount }
  end

end
