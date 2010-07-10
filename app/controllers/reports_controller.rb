class ReportsController < ApplicationController
  def report
    @tags = Tag.report_by_percentage params[:initial_date], params[:end_date], params[:percentage]
    @total = @tags.inject(0) { |sum, e| sum + e.total }
  end
  
  def create
    
  end
end
