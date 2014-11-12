class AddAttributesToPromotionAndTestimonials < ActiveRecord::Migration
  def change
    add_column :promotions, :position, :integer
    add_column :promotions, :display, :boolean, null: false, default: true
    add_index :promotions, :display
    add_index :testimonials, :display
  end
end
