class UsersController < ApplicationController
  before_action :require_signed_in!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def show
  end
  
  def create
    @users = User.all
    @user = User.new(permitted_params.user)
    
    if @user.save
      flash[:notices] = ["User created!"]
      redirect_to users_url
    else
      fail
      flash.now[:errors] = @user.errors.full_messages
      render :index
    end
  end
  
  def edit

  end
  
  def update
    if @user.update(permitted_params.user)
      flash.now[:notices] = ["User updated successfully!"]
      @status = :accepted
    else
      flash.now[:errors] = @user.errors.full_messages
       @status = :unprocessable_entity
    end
    
    render :edit, status: @status
  end
  
  def destroy
    @user.destroy
    
    flash[:notices] = ["User #{@user.name} deleted!"]
    redirect_to :index
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    
    @user_params || params[:user].each do |key, value|
      if key =~ /(.+)_phone$/ || key == "fax"
        params[:user][key] = value.gsub(/\D/, '')
      end
    end
    
    @user_params ||= params.require(:user).permit(:avatar, :first_name, :last_name, :email, :home_phone, :work_phone, :mobile_phone, :fax, :bio, :position, :title)
  end
end
