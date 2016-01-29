class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  def show # 追加
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_settings)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end
  
  def edit
    logged_in_user
  end
  
  def update
    if @user.update(user_settings)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def user_settings
    params.require(:user).permit(:name, :age, :country, :email, :password, :password_confirmation, :profile)
  end
  
  def set_user
    @user = current_user
  end
end
