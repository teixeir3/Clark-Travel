class PermittedParams < Struct.new(:params, :current_user)
  def user
    
    # Format Phone numbers:
    @user_params || params.require(:user).each do |key, value|
      if key =~ /(.+)_phone$/ || key == "fax"
        params[:user][key] = value.gsub(/\D/, '')
      end
    end

    @user_params ||= params.require(:user).permit(user_attributes)
  end
  
  def user_attributes
    if current_user && current_user.is_admin?
      @user_attributes ||= [:avatar, :first_name, :last_name, :email,
        :home_phone, :work_phone, :mobile_phone,
        :fax, :bio, :position, :title, :is_admin]
    else
      @user_attributes ||= [:avatar, :first_name, :last_name, :email,
        :home_phone, :work_phone, :mobile_phone,
        :fax, :bio, :position, :title]
    end
    
    @user_attributes.delete(:email) if params[:email_confirmation] && params.require(:user)[:email] != params[:email_confirmation]
    
    @user_attributes
  end
  
  # Not backed up by a model.
  # TODO: Make a form model for contact_me form
  def contact_me
    @contact_me_params ||= params.require(:contact_me).permit(contact_me_attributes)
  end
  
  def contact_me_attributes
    @contact_me_attributes ||= [:name, :phone, :email, :inquiry]
  end
  
  def german_cruising_form
     @german_cruising_params ||= params.require(:contact_me).permit(german_cruising_form_attributes)
  end
  
  # TODO WIP fill in german_cruising_formsn#new.html.erb german_cruising_form_.rb
  def german_cruising_form_attributes
    @german_cruising_attributes ||= []
  end
  
  def promotion
    @promotion_params ||= params.require(:promotion).permit(promotion_attributes)
  end
  
  def promotion_attributes
    @promotion_attributes ||= [:title, :highlight, :body, :start_date, :expiration_date, :picture, :position, :display, :carousel_display, :facebook_publish]
  end
  
  def testimonial
    @testimonial_params ||= params.require(:testimonial).permit(testimonial_attributes)
  end
  
  def testimonial_attributes
    @testimonial_attributes ||= [:signature, :body, :highlight, :display, :position]
  end
  
  def booking_category
    @booking_category_params ||= params.require(:booking_category).permit(booking_category_attributes)
  end
  
  def booking_category_attributes
    @booking_category_attributes ||= [:title, :description, :display, :position, :user, :picture]
  end
  
  def booking
    @booking_params ||= params.require(:booking).permit(booking_attributes)
  end
  
  def booking_attributes
    @booking_attributes ||= [:title, :url, :display, :position, :carousel_display, :picture]
  end
end