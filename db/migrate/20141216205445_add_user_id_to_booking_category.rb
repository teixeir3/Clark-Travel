class AddUserIdToBookingCategory < ActiveRecord::Migration
  def change
    add_column :booking_categories, :user_id, :integer, null: false
    add_index :booking_categories, :user_id
  end
end
