class ReportsController < ApplicationController
  def create
    @tags = Tag.report_by_percentage params[:initial_date], params[:end_date], params[:percentage]
  end
end
