class ChangePromotionFacebookIDtoString < ActiveRecord::Migration
  def change
     change_column :promotions, :facebook_id, :string
  end
end
