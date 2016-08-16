class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_testimonials, :set_facebook_feed
  before_action :set_booking_category
  
  helper_method :current_user, :current_user_is_admin? ,:permitted_params, :signed_in?
  
  include ApplicationHelper
  
  private
  
  def set_facebook_feed
    user = User.find_by_last_name("Teixeira")
    @feed ||= user.facebook.get_connection("clarktravelagency", "feed", {limit: 15}) if user && user.valid_facebook?
  end
  
  def nested_booking?
    (params[:booking_category_id]) ? true : false
  end
  
  def set_booking_category
    @booking_category = BookingCategory.find(params[:booking_category_id]) if nested_booking?
  end
  
  def set_testimonials
    @testimonials ||= Testimonial.all_display
  end
  
  def set_return_url
    puts "SETTING SESSION[:RETURN_URL] AS #{session[:return_url]}"
    session[:return_url] = request.referrer
  end

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def current_user_is_admin?
    signed_in? && current_user.is_admin?
  end

  def signed_in?
    !!current_user
  end

  def sign_in(user)
    @current_user = user
    session[:token] = user.reset_session_token!
  end

  def sign_out!
    current_user.try(:reset_session_token!)
    session[:token] = nil
  end

  def require_signed_in!
    unless signed_in?
      flash[:errors] = ["You must be signed in to access this page!"]
      redirect_to new_session_url
    end
  end
  
  def require_admin_signed_in!
    unless current_user_is_admin?
      flash[:errors] = ["Only administrators can access this page!"]
      redirect_to session[:return_url]
    end
  end

  def require_signed_out!
    if signed_in?
      flash[:errors] = ["You must be signed out to access this page!"]
      redirect_to users_url
    end
  end

  def password_confirmed?
    params[:password] != params[:user][:password]
  end

  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
  end
end
