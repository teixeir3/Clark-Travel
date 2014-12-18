class RemoveUserIdFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :user_id
  end
end
