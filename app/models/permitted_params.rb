class PermittedParams < Struct.new(:params, :current_user)
  def user
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
end