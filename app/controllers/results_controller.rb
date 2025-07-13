class ResultsController < ApplicationController
  def show
    @result = Result.find_by(category: params[:id])
    session[:last_result_category] = @result.category if @result.present?
  end
  def index
    @results = Result.all
  end
end
