class ReportsController < ApplicationController
  def index
  end

  def report_by_category
    operations = Operation
      .where('odate BETWEEN ? AND ?', params[:start_date], params[:end_date])
      .group(:category_id)
      .sum(:amount)
  
    @amounts = operations.values
    category_ids = operations.keys
    @category_names = Category.where(id: category_ids).pluck(:name)
  end

  def report_by_dates
    operations = Operation
      .where('odate BETWEEN ? AND ?', params[:start_date], params[:end_date])
      .group(:odate)
      .sum(:amount)
  
    @amounts = operations.values.map { |amount| amount.to_f }
    @dates = operations.keys.map { |date| date.to_date.to_s }
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