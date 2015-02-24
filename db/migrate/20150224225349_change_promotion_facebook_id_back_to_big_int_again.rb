class ChangePromotionFacebookIdBackToBigIntAgain < ActiveRecord::Migration
  def change
     change_column :promotions, :facebook_id, :bigint
  end
end
