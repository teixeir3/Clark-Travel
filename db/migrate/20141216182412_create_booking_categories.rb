class CreateBookingCategories < ActiveRecord::Migration
  def change
    create_table :booking_categories do |t|
      t.string :title, null: false
      t.integer :position
      t.text :description
      t.timestamps
    end
  end
end
