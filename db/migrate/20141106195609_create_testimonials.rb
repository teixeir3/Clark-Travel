class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.string :highlight
      t.text :body
      t.integer :user_id, null: false
      t.string :signature, null: false
      t.boolean :display, null: false, default: true
      t.integer :position
      
      t.timestamps
    end
    
    add_index :testimonials, :user_id
  end
end
