class ReportsController < ApplicationController
  def index
  end

  def report_by_category
    operations_by_categories = Operation.all.map { |oper| 
      [oper.amount.to_f, oper.category_id] if oper.odate >= params[:start_date] && oper.odate <= params[:end_date]
      }
    
    categories_array = Category.all.map { |c| [c.id, c.name]}
    
    @amount = categories_array.map { |c| c[0] }
    
    @category_by_id = categories_array.map { |c| c[1] }
  end

  def report_by_dates
    operations_array = Operation.all.map { |oper| 
      [oper.amount.to_f, oper.odate.to_s] if oper.odate >= params[:start_date] && oper.odate <= params[:end_date]
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