class AddFbPublishedAtToPromotions < ActiveRecord::Migration
  def change
    add_column :promotions, :facebook_published_at, :datetime
  end
end
