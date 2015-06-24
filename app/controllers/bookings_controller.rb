class BookingsController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create, :edit, :update, :destroy, :sort]
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  # before_action :set_booking_category
  
  def index
    @active_bookings = BookingCategory.all_active
  end

  def new
    @booking = current_user.bookings.new
  end

  def create
    @booking = current_user.bookings.build(permitted_params.booking)

    if @booking.save
      flash.now[:notices] = ["Booking Link created!"]
      @booking.publish_to_facebook if @booking.facebook_publish
      render :edit
    else
      flash.now[:errors] = @booking.errors.full_messages
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @booking.update_attributes(permitted_params.booking)
      flash.now[:notices] = ["Booking Link Updated."]
    else
      flash.now[:errors] = @booking.errors.full_messages
    end
    
    render :edit
  end

  def destroy
    @booking.destroy
    flash[:notice] = ["Booking \"#{@booking.title}\" deleted!"]
    
    
    respond_to do |format|
      format.html { redirect_to :root }
      format.js { render :nothing, status: :deleted }
    end
  end
  
  def sort
    params[:booking].each_with_index do |id, index|
      Booking.update_all({position: index+1}, {id: id})
    end
    
    render nothing: true
  end
  
  private
  
 
  def set_booking
    @booking = Booking.find(params[:id])
  end

 
end