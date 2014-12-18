class PromotionsController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create, :edit, :update, :destroy, :sort]
  before_action :set_promotion, only: [:show, :edit, :update, :destroy]
  
  # Root URL
  def index
    @active_promotions = Promotion.all_active
    @promotions = Promotion.all(order: "expiration_date")
    @carousel_bookings = Booking.carousel_bookings
  end

  def new
    @promotion = current_user.promotions.new
  end

  def create
    @promotion = current_user.promotions.build(permitted_params.promotion)

    if @promotion.save
      flash.now[:notices] = ["Promotion created!"]
      @promotion.publish_to_facebook if @promotion.facebook_publish
      render :edit
    else
      flash.now[:errors] = @promotion.errors.full_messages
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @promotion.update_attributes(permitted_params.promotion)
      flash.now[:notices] = ["Promotion Updated."]
    else
      flash.now[:errors] = @promotion.errors.full_messages
    end
    
    render :edit
  end

  def destroy
    @promotion.destroy
    flash[:notice] = ["Promotion \"#{@promotion.title}\" deleted!"]
    redirect_to :root
  end
  
  def sort
    params[:promotion].each_with_index do |id, index|
      Promotion.update_all({position: index+1}, {id: id})
    end
    
    render nothing: true
  end
  
  private
  
 
  def set_promotion
    @promotion = Promotion.find(params[:id])
  end

end
