class ChangePromotionFacebookIdBackToInt < ActiveRecord::Migration
  def change
    change_column :promotions, :facebook_id, :int
  end
end
