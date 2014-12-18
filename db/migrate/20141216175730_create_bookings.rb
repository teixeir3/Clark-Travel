class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :title, null: false
      t.integer :user_id, null: false
      t.string :url, null: false
      t.integer :position
      t.boolean :display, null: false, default: true
      
      t.timestamps
    end
    
    add_index :bookings, :user_id
    add_index :bookings, :display
    add_attachment :bookings, :picture
  end
end
