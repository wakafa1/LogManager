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
end
