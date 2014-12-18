class UsersController < ApplicationController
  before_action :require_signed_in!, only: [:new, :creat, :edit, :update, :sort, :destroy ]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.where(display: true).all(order: "position")
  end
  
  def new
    @user = User.new
  end
  
  def show
    @promotion = (@user.promotions.find(params[:inquiry_id]) if params[:inquiry_id]) || @user.promotions.build(title: params[:inquiry])
  end
  
  def create
    @users = User.all
    @user = User.new(permitted_params.user)
    
    fail
    if @user.save
      flash[:notices] = ["User created!"]
      redirect_to users_url
    else
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
  
  def sort
    params[:user].each_with_index do |id, index|
      User.update_all({position: index+1}, {id: id})
    end
    
    render nothing: true
  end
  
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
 
  # def user_params
  #   @user_params || params[:user].each do |key, value|
  #     if key =~ /(.+)_phone$/ || key == "fax"
  #       params[:user][key] = value.gsub(/\D/, '')
  #     end
  #   end
  #
  #   @user_params ||= params.require(:user).permit(:avatar, :first_name, :last_name, :email, :home_phone, :work_phone, :mobile_phone, :fax, :bio, :position, :title)
  # end
end
