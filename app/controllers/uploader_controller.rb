class UploaderController < ApplicationController
  def upload
  end

  def do_upload
    require 'fileutils'
    @uploaded_io = params[:logfile]

    # Set ./public/upload/ as upload folder. If not exist, create it
    @upload_folder = Rails.root.join('public','uploads')
    @upload_filename = Rails.root.join(@upload_folder, @uploaded_io.original_filename)
    FileUtils.makedirs(@upload_folder) unless File.exists?@upload_folder

    # Write file to @upload_folder/original_filename
    File.open(@upload_filename, 'wb') do |file|
      file.write(@uploaded_io.read)
    end
  end
end