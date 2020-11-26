module SessionsHelper
  # 请在下面完成要求的功能
  #*********begin*********#
  # 使用持久会话记录用户数据
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 返回当前系统登录用户
  def current_user
    if !@current_user.nil?
        return @current_user
    end
    if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
        user = User.find_by(id: user_id)
        if user && user.authenticated?(cookies[:remember_token])
            log_in user
            @current_user = user
        end
    else
        return nil
    end
  end

  # 清除用户 cookies 及访问令牌
  # 不再使用持久会话记录用户数据
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # 对当前用户做登出操作
  def log_out
    forget(@current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  #********* end *********#

  # 对指定用户做登录操作
  def log_in(user)
    session[:user_id] = user.id
  end

  # 返回当前是否存在已登录用户
  def logged_in?
    !current_user.nil?
  end
end
