class ReportsController < ApplicationController
  def index
  end

  def report_by_category
    @amounts = Operation
    .model_report_by_category(params[:start_date], params[:end_date])
    .values

    category_ids = Operation
    .model_report_by_category(params[:start_date], params[:end_date])
    .keys

    @category_names = Category
    .where(id: category_ids)
    .pluck(:name)
  end

  def report_by_dates
    @amounts = Operation
    .model_report_by_dates(params[:start_date], params[:end_date])
    .values
    .map { |amount| amount.to_f }

    @dates = Operation
    .model_report_by_dates(params[:start_date], params[:end_date])
    .keys
    .map { |date| date.to_date.to_s }
    
    #Operation.model_report_by_dates(params[:start_date], params[:end_date])    
  end
  
  def action_report
    if params[:btn_graph]
      redirect_to({
        action: "report_by_category",
        start_date: params[:start_date],
        end_date: params[:end_date]
        })
    elsif params[:btn_dates]
      redirect_to({
        action: "report_by_dates",
        start_date: params[:start_date],
        end_date: params[:end_date],
        categories: params[:categories]
        })
    end
  end
end