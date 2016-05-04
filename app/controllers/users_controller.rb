# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      not null
#  password_digest        :string(255)      not null
#  session_token          :string(255)      not null
#  first_name             :string(255)
#  last_name              :string(255)
#  phone                  :string(255)
#  is_admin               :boolean          default(FALSE), not null
#  created_at             :datetime
#  updated_at             :datetime
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  is_active              :boolean          default(FALSE), not null
#  activation_token       :string(255)      default("INACTIVE"), not null
#  uid                    :string(255)
#  access_token           :string(255)
#  provider               :string(255)
#  position               :integer
#  title                  :string(255)
#  bio                    :text
#  work_phone             :string(255)
#  home_phone             :string(255)
#  mobile_phone           :string(255)
#  fax                    :string(255)
#  oauth_token            :string(255)
#  oauth_expires_at       :datetime
#  fb_image_url           :string(255)
#  display                :boolean          default(TRUE), not null
#

class UsersController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create, :edit, :update, :sort, :destroy, :update_facebook_auth, :activate]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :send_contact_me_email]
  
  def index
    @users = User.where(display: true).order(:position).all
  end
  
  def new
    @user = User.new
  end
  
  def show
    @promotion = (Promotion.where(id: params[:inquiry_id])) || @user.promotions.build(title: params[:inquiry]) if params[:inquiry_id]
  end
  
  def create
    @users = User.all
    @user = User.new(permitted_params.user)
    
    if @user.save
      UserMailer.activation_email(@user).deliver!
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
    
    
    respond_to do |format|
      format.html { 
        flash[:notices] = ["User #{@user.name} deleted!"]
        redirect_to users_url
      }
      format.json { head :no_content }
      format.js {
        flash.now[:notices] = ["User #{@user.name} deleted!"]
      }
    end
  end
  
  def sort
    params[:user].each_with_index do |id, index|
      User.update_all({position: index+1}, {id: id})
    end
    
    render nothing: true
  end
  
  def activate
    @user = User.find_by_activation_token(params[:activation_token])
    
    if params[:activation_token] && @user
      @user.activate!
      sign_in(@user)
      flash[:notices] =  ["Successfully activated your account!"]
      redirect_to @user
    else
      raise ActiveRecord::RecordNotFound.new()
    end
  end
  
  
  def send_contact_me_email
    @user.send_contact_me_email(permitted_params.contact_me)
    flash[:notices] = ["Message Sent!"]
    redirect_to user_url(@user)
  end
  
  def update_facebook_auth
    @user = current_user
    @user.update_omniauth!(env["omniauth.auth"])
    
    if @user.valid?
      flash.now[:notices] = ["Facebook Credentials Added!"]
    else
      flash.now[:errors] = ["An Error Has Occurred!"] + @user.errors.full_messages
    end
    
    render :edit
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
