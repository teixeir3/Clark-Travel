class PromotionsController < ApplicationController
  before_filter :require_signed_in!,
    only: [:new, :create, :edit, :update, :destroy]

  def index
    @promotions = Promotion.all_active
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
    @promotion = Promotion.find(params[:id])
  end

  def edit
    @promotion = Promotion.find(params[:id])
  end

  def update
    @promotion = Promotion.find(params[:id])
  end

  def destroy
    @promotion = Promotion.find(params[:id])
  end

end
