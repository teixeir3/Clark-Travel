class UsersController < ApplicationController
  
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
  end
  
  def destroy
    @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:avatar, :first_name, :last_name)
  end
end
