class ReportsController < ApplicationController
  def index
  end

  def report_by_category
    @categories_array = Operation.all.map { |oper| 
      [oper.amount, oper.category_id] if oper.odate >= params[:start_date] && oper.odate <= params[:end_date]
      }
    puts(@categories_array)
  end

  def report_by_dates
    @operations_array = Operation.all.map { |oper| 
      [oper.amount, oper.odate] if oper.odate >= params[:start_date] && oper.odate <= params[:end_date]
      }
    puts(@operations_array)
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