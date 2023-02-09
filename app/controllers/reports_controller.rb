class ReportsController < ApplicationController
  def index
  end

  def report_by_category
    oper_arr = Operation
      .where('odate BETWEEN ? AND ?', params[:start_date], params[:end_date])
      .group(:category_id)
      .sum(:amount)
    @amount = oper_arr.map { |a| a[1] }
    @category_id = Category.find(oper_arr.map { |a| a[0] }).map { |c| [c.name] }
  end

  def report_by_dates
    oper_arr = Operation
      .where('odate BETWEEN ? AND ?', params[:start_date], params[:end_date])
      .order(:odate)
      .group(:odate)
      .sum(:amount)
    
    @amount = oper_arr.map { |amount| amount[1].to_f }
    @dates = oper_arr.map { |date| date[0].to_date.to_s }
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