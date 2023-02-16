class ReportsController < ApplicationController
  def index
  end

  def report_by_category
    @categories_and_amount = Operation
    .model_report_by_category(params[:start_date], params[:end_date], params[:type_operations])

    @amounts = @categories_and_amount.values

    @category_names = @categories_and_amount.keys
  end

  def report_by_dates
    @dates_and_amounts = Operation
    .model_report_by_dates(params[:start_date], params[:end_date], params[:category_id])
    
    @dates = @dates_and_amounts.keys.map { |date| date.to_date.to_s }
        
    @amounts = @dates_and_amounts.values.map { |amount| amount.to_f }
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