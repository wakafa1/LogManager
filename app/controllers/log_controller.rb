class LogController < ApplicationController
  def profile
    @current_log = Log.find(params[:id])
  end
end
