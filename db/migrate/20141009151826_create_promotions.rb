class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :title, null: false
      t.integer :user_id, null: false
      t.text :highlight
      t.text :body
      t.date :start_date
      t.date :expiration_date
      t.timestamps
    end
    
    add_index :promotions, :user_id
    add_attachment :promotions, :picture
  end
end
