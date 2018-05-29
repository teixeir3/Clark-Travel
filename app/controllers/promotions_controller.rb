# == Schema Information
#
# Table name: promotions
#
#  id                    :integer          not null, primary key
#  title                 :string(255)      not null
#  user_id               :integer          not null
#  highlight             :text
#  body                  :text
#  start_date            :date
#  expiration_date       :date
#  created_at            :datetime
#  updated_at            :datetime
#  picture_file_name     :string(255)
#  picture_content_type  :string(255)
#  picture_file_size     :integer
#  picture_updated_at    :datetime
#  position              :integer          default(0), not null
#  display               :boolean          default(TRUE), not null
#  facebook_publish      :boolean          default(FALSE), not null
#  carousel_display      :boolean          default(FALSE), not null
#  facebook_published_at :datetime
#  facebook_id           :string(255)
#

class PromotionsController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create, :edit, :update, :destroy, :sort]
  before_action :set_promotion, only: [:show, :edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 
  # after_action :push_to_facebook, only: [:create, :update]
  
  # Root URL
  def index
    @active_promotions = Promotion.all_active
    (@all_promotions = Promotion.order(:expiration_date).all) if current_user_is_admin?
    @carousel_bookings = Booking.carousel_bookings
  end

  def new
    @promotion = current_user.promotions.new
  end

  def create
    @promotion = current_user.promotions.build(permitted_params.promotion)

    if @promotion.save
      push_to_facebook
      flash.now[:notices] = ["Promotion created!"]
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
      push_to_facebook
    else
      flash.now[:errors] = @promotion.errors.full_messages
    end
    
    render :edit
  end

  def destroy
    @promotion.destroy
    flash[:notice] = ["Promotion \"#{@promotion.title}\" deleted!"]

    respond_to do |format|
      format.html { redirect_to :root }
      format.js { render :nothing, status: :deleted }
    end
  end
  
  def sort
    params[:promotion].each_with_index do |id, index|
      Promotion.update_all({position: index+1}, {id: id})
    end
    
    render nothing: true
  end
  
  private
  
  def push_to_facebook
    sleep 10
    @promotion.publish_to_facebook!
  end
 
  #TODO: refactor to a helper method that all controllers can use for their models
  def set_promotion
    @promotion = Promotion.find(params[:id])
  end
  
  # Refactor to a helper
  def record_not_found
    flash[:errors] = ["Record not found."]
    redirect_to promotions_path
  end

end
