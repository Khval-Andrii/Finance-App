class ReportsController < ApplicationController
  def index
  end

  def report_by_category
    @amounts = Operation
    .model_report_by_category(params[:start_date], params[:end_date], params[:type_operations])
    .values

    @category_names = Operation
    .model_report_by_category(params[:start_date], params[:end_date], params[:type_operations])
    .keys
  end

  def report_by_dates
    @amounts = Operation
    .model_report_by_dates(params[:start_date], params[:end_date], params[:category_id])
    .values
    .map { |amount| amount.to_f }

    @dates = Operation
    .model_report_by_dates(params[:start_date], params[:end_date], params[:category_id])
    .keys
    .map { |date| date.to_date.to_s }
  end
  
  def action_report
    if params[:btn_graph]
      redirect_to({
        action: "report_by_category",
        start_date: params[:start_date],
        end_date: params[:end_date],
        type_operations: params[:type_operations]
        })
    elsif params[:btn_dates]
      redirect_to({
        action: "report_by_dates",
        start_date: params[:start_date],
        end_date: params[:end_date],
        category_id: params[:category_id]
        })
    end
  end
end