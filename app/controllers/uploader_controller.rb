class UploaderController < ApplicationController
  include SessionsHelper

  def upload
  end

  def do_upload
    require 'fileutils'
    @uploaded_io = params[:logfile]
    if @uploaded_io.nil?
      flash.now[:danger] = "请选择文件！"
      render :upload
      return
    end

    # Set ./public/upload/ as upload folder. If not exist, create it
    @upload_folder = Rails.root.join('public','uploads')
    @upload_filename = Rails.root.join(@upload_folder, @uploaded_io.original_filename)
    FileUtils.makedirs(@upload_folder) unless File.exists?@upload_folder

    # Write file to @upload_folder/original_filename
    File.open(@upload_filename, 'wb') do |file|
      file.write(@uploaded_io.read)
    end

    # Assign log to current_user
    if current_user.nil?
      flash.now[:danger] = "您尚未登陆！"
      render :upload
    else
      puts current_user
    end
    @log = Log.new
    @log.filename = @upload_filename
    @log.user = current_user
    @log.parsed = false
    @log.save
  end
end