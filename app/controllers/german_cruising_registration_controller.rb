class GermanCruisingRegistrationController < ApplicationController
  before_action :set_german_cruising_form
  
  def new

  end
  
  def create
    if @german_cruising_form.valid?
      UserMailer.german_cruising_registration_email(@german_cruising_form).deliver
      flash[:notices] = ["Registration Sent!"]
      redirect_to page_path("german_cruising")
    else
      flash.now[:errors] = @german_cruising_form.error.full_messages
      render :new
    end
  end
  
  private
  
  def set_german_cruising_form
    @german_cruising_form = GermanCruisingForm.new(permitted_params.german_cruising_form)
  end
end
