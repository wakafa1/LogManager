class LogController < ApplicationController
  include LogHelper

  def profile
    !check_permission ? return :
    @current_log = Log.find(params[:id])
  end
end
