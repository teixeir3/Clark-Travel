class AddCarouselDisplayToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :carousel_display, :boolean, null: false, default: false
    add_index :bookings, :carousel_display
  end
end
