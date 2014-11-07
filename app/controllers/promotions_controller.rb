class PromotionsController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_promotion, only: [:show, :edit, :update, :destroy]
  
  # Root URL
  def index
    @active_promotions = Promotion.all_active
    @promotions = Promotion.all
  end

  def new
    @promotion = current_user.promotions.new
  end

  def create
    @promotion = current_user.promotions.build(permitted_params.promotion)

    if @promotion.save
      flash.now[:notices] = ["Promotion created!"]
      render :show
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
  
  private
  
  def set_promotion
    @promotion = Promotion.find(params[:id])
  end

end
