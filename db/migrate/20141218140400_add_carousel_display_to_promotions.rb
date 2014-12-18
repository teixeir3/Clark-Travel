class AddCarouselDisplayToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :carousel_display, :boolean, null: false, default: false
    add_index :promotions, :carousel_display
  end
end
