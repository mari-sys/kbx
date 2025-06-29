class ResultsController < ApplicationController
  def show
    @result = Result.find_by(category: params[:id])
  end
end
