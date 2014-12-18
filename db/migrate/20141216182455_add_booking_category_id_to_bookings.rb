class AddBookingCategoryIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :category_id, :integer, null: false
    add_index :bookings, :category_id
  end
end
