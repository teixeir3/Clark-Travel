class AddImagesAndDisplayToBookingCategory < ActiveRecord::Migration
  def change
    add_attachment :booking_categories, :picture
    add_column :booking_categories, :display, :boolean, null: false, default: true
    add_index :booking_categories, :display
  end
end
