class UsersController < ApplicationController
  before_filter :require_signed_in!, only: [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def new
    
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.create(user_params)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    user_params[:mobile_phone] = user_params[:mobile_phone].gsub(/\D/, '')
    fail
  end
  
  def destroy
    @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:avatar, :first_name, :last_name,
      :email, :home_phone, :work_phone, :mobile_phone, :fax, :bio,
      :position, :title)
  end
end
