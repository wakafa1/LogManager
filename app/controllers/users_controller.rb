class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  # 请在下面完成要求的功能
  #*********begin*********#
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end
  #********* end *********#

  private

    # 请在下面完成要求的功能
    #*********begin*********#
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    #********* end *********#
end
