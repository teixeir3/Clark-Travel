class GermanCruisingForm
  include ActiveModel::Model
  
  attr_accessor :customer, :home_phone, :alt_phone, :cell_phone, :email
  
  # TODO Need to add attribute validations

  def send_email
    UserMailer.german_cruising_form_email(self).deliver
  end
  
  def persisted?
    false
  end

  

  validate :verify_original_password
  validates_presence_of :original_password, :new_password
  validates_confirmation_of :new_password
  validates_length_of :new_password, minimum: 6

  def initialize(user)
    @user = user
  end

  def submit(params)
    self.original_password = params[:original_password]
    self.new_password = params[:new_password]
    self.new_password_confirmation = params[:new_password_confirmation]
    
    if valid?
      @user.password = new_password
      @user.save!
      true
    else
      false
    end
  end
end