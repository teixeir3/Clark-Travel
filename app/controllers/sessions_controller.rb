class SessionsController < ApplicationController
  before_filter :require_signed_out!, :only => [:new, :create]
  before_filter :require_signed_in!, :only => [:destroy]
  
  def new
    respond_to do |format|
      format.html{ render :new }
      format.js { render :new }
    end
  end
  
  def create
    google_data = request.env["omniauth.auth"]

    if google_data
      @user = User.where(provider: google_data["provider"], uid: google_data["uid"]).first

      unless @user
        @user = create_from_google_data(google_data)
      end

    else
      @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password])
    end

    if @user
      sign_in(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Incorrect credentials"]
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to new_session_url
  end
end
