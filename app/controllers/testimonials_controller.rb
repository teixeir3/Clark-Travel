# == Schema Information
#
# Table name: testimonials
#
#  id         :integer          not null, primary key
#  highlight  :string(255)
#  body       :text
#  user_id    :integer          not null
#  signature  :string(255)      not null
#  display    :boolean          default(TRUE), not null
#  position   :integer
#  created_at :datetime
#  updated_at :datetime
#

class TestimonialsController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create, :edit, :update, :destroy, :sort]
  before_action :set_testimonial, only: [:show, :edit, :update, :destroy]
  
  def index
    @testimonial = current_user.testimonials.new if current_user_is_admin?
  end

  def new
    @testimonial = current_user.testimonials.new
  end

  def create
    @testimonial = current_user.testimonials.build(permitted_params.testimonial)
    
    
    if @testimonial.save
      flash.now[:notices] = ["Testimonial created!"]
      @testimonial = current_user.testimonials.new if current_user_is_admin?
    else
      flash.now[:errors] = @testimonial.errors.full_messages
    end
    
    @testimonials = Testimonial.all_display
    render :index
  end

  def show

  end

  def edit

  end

  def update
    if @testimonial.update_attributes(permitted_params.testimonial)
      flash.now[:notices] = ["Testimonial Updated."]
    else
      flash.now[:errors] = @testimonial.errors.full_messages
    end
    
    render :edit
  end

  def destroy
    @testimonial.destroy
    flash[:notice] = ["Testimonial \"#{@testimonial.highlight}\" deleted!"]
    redirect_to testimonials_url
  end
  
  def sort
    params[:testimonial].each_with_index do |id, index|
      Testimonial.update_all({position: index+1}, {id: id})
    end
    
    render nothing: true
  end
  
  private
  
  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  end
end
