class AddFacebookIdToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :facebook_id, :integer
    add_index :promotions, :facebook_id, unique: true 
  end
end
