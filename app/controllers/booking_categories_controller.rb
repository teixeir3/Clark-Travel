# == Schema Information
#
# Table name: booking_categories
#
#  id                   :integer          not null, primary key
#  title                :string(255)      not null
#  position             :integer
#  description          :text
#  created_at           :datetime
#  updated_at           :datetime
#  user_id              :integer          not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  display              :boolean          default(TRUE), not null
#

class BookingCategoriesController < ApplicationController
    before_action :require_signed_in!, only: [:new, :create, :edit, :update, :destroy, :sort]
    before_action :set_booking_category, only: [:show, :edit, :update, :destroy]
  
    def index
      @active_booking_categories = BookingCategory.all_active
      
      
    end

    def new
      @booking_category = current_user.booking_categories.new
    end

    def create
      @booking_category = current_user.booking_categories.build(permitted_params.booking_category)

      if @booking_category.save
        flash.now[:notices] = ["Booking Category: #{@booking_category.title} created!"]
        render :edit
      else
        flash.now[:errors] = @booking_category.errors.full_messages
        render :new
      end
    end

    def show
      @category_bookings = @booking_category.bookings.order(:position)
    end

    def edit

    end

    def update
      if @booking_category.update_attributes(permitted_params.booking_category)
        flash.now[:notices] = ["Promotion Updated."]
      else
        flash.now[:errors] = @booking_category.errors.full_messages
      end
    
      render :edit
    end

    def destroy
      @booking_category.destroy
      flash[:notice] = ["Category \"#{@booking_category.title}\" deleted!"]
      redirect_to :index
    end
  
    def sort
      params[:booking_category].each_with_index do |id, index|
        BookingCategory.update_all({position: index+1}, {id: id})
      end
    
      render nothing: true
    end
  
    private
  
 
    def set_booking_category
      @booking_category = BookingCategory.find(params[:id])
    end
  
end
