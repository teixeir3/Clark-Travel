class GermanCruisingForm
  include ActiveModel::Model
  
  # attr_accessor :first_name_1, :last_name_1, :street_1, :city_1, :state_1, :zip_1, :birthdate_1, :first_name_2, :last_name_2, :street_2, :city_2, :state_2, :zip_2, :birthdate_2, :first_name_3, :last_name_3, :street_3, :city_3, :state_3, :zip_3, :birthdate_3, :first_name_4, :last_name_4, :street_4, :city_4, :state_4, :zip_4, :birthdate_4, :home_phone, :alt_phone, :cell_phone, :email, :booking_date, :cabin, :air, :transfers, :insurance, :dining_main_seating, :special_event_requests, :cabin_circle_num, :cabin_upgrade, :cc_name, :cc_address, :cc_type, cc_number:, :cc_exp, :cc_ccv
#


  validates_presence_of :home_phone, :email

  
  def initialize(attributes = {})
    super
  end
  
  def send_email
    UserMailer.german_cruising_form_email(self).deliver
  end
  
  def persisted?
    false
  end

  def submit(params)
    # self.original_password = params[:original_password]
 #    self.new_password = params[:new_password]
 #    self.new_password_confirmation = params[:new_password_confirmation]
    
    if valid?
      # @user.password = new_password
 #      @user.save!
      true
    else
      false
    end
  end
end