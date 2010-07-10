class ReportsController < ApplicationController
  def report
    @tags = Tag.report_by_percentage params[:initial_date], params[:end_date], params[:percentage]
  end
  
  def create
    
  end
end
