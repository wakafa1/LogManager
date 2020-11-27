module LogHelper
  include SessionsHelper
  def check_permission
    if current_user.nil?
      redirect_to :login
      false
    else
      true
    end
  end

  def parse_log(log)
    if log.parsed
      return
    end
    puts log.filename
    File.open(log.filename, "r") do |file|
      file.read.each_line do |line|
        info = line.split(" ")
        puts info[1]
        datapoint = Datapoint.new
        datapoint.time = Integer(info[0])
        datapoint.field = info[1]
        datapoint.data = Integer(info[2])
        datapoint.log = log
        datapoint.save
      end
    end
    log.parsed = true
    log.save
  end
end
