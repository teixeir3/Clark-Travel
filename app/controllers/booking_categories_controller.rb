class BookingCategoriesController < ApplicationController
    before_action :require_signed_in!, only: [:new, :create, :edit, :update, :destroy, :sort]
    before_action :set_booking_category, only: [:show, :edit, :update, :destroy]
  
    def index
      @active_booking_categories = BookingCategory.all_active
    end

    def new
      @booking_category = current_user.booking_categorys.new
    end

    def create
      @booking_category = current_user.booking_categorys.build(permitted_params.booking_category)

      if @booking_category.save
        flash.now[:notices] = ["Promotion created!"]
        @booking_category.publish_to_facebook if @booking_category.facebook_publish
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
