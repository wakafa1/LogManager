class LogController < ApplicationController
  include LogHelper

  def profile
    if !check_permission
      return
    end
    @current_log = Log.find(params[:id])
  end

  def parse
    @current_log = Log.find(params[:id])
    puts @current_log.filename
    if !check_permission or @current_log.nil?
      flash.now[:danger] = "您尚未登陆！"
      render :parse
      return
    end
    parse_log @current_log
  end
end
