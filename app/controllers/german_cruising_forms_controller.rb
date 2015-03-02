class GermanCruisingFormsController < ApplicationController
  # before_action :set_german_cruising_form
  
  def new
    @german_cruising_form = GermanCruisingForm.new
  end
  
  # TODO is it more RESTful to change this action name because it's not creating any db records?
  def create
    @german_cruising_form = GermanCruisingForm.new(permitted_params.german_cruising_form)
    
    if @german_cruising_form.valid?
      @german_cruising_form.send_email
      flash[:notices] = ["Sending Registration Form!"]
      redirect_to page_path("german_cruising")
    else
      flash.now[:errors] = @german_cruising_form.error.full_messages
      render :new
    end
  end
  
  private
  
  # def set_german_cruising_form
  #   @german_cruising_form = GermanCruisingForm.new(permitted_params.german_cruising_form)
  # end
end
