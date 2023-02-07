class ReportsController < ApplicationController
  def index
  end

  def report_by_category
    oper_arr = Operation
      .order(:odate)
      .where('odate BETWEEN ? AND ?', params[:start_date], params[:end_date])
      .group(:category_id)
      .sum(:amount)
    @amount = oper_arr.map { |a| a[1] }
   # puts(@amount)
    @category_id = Category.find(oper_arr.map { |a| a[0] }).map { |c| [c.name] }
    #puts(@category_id)
  end

  def report_by_dates
    operations_array = Operation.all.map { |oper| 
      [oper.amount.to_f, oper.odate.to_date.to_s] if oper.odate >= params[:start_date] && oper.odate <= params[:end_date]
      }
    
    @amount = operations_array.map { |amount| amount[0] } 
    @dates = operations_array.map { |date| date[1] }
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