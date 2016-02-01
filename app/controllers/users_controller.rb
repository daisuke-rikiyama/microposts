# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  profile         :string
#  age             :integer
#  country         :string
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def show # 追加
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
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
  end
  
  def update
    if @user.update(user_settings)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.following_users.order(:id)
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_users.order(:id)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def user_settings
    params.require(:user).permit(:name, :age, :country, :email, :password, :password_confirmation, :profile)
  end
  
  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:danger] = "Operation of a different user is prohibited"
      redirect_to root_path
    end
  end
end
