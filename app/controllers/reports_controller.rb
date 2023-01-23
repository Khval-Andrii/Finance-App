class ReportsController < ApplicationController
  def index
  end

  def report_by_category
    puts("tuhes")
  end

  def report_by_dates
    puts("ass")
  end

  def action_report
    if params[:btn_graph]
      redirect_to({
        action: "report_by_category",
        #start_date: params[:start_date],
        #end_date: params[:end_date]
        })
    elsif params[:btn_dates]
      redirect_to({
        action: "report_by_dates",
        start_date: params[:start_date],
        end_date: params[:end_date]
        })
    end
  end

end