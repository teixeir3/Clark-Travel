class AddDefaultValueToPromotionPosition < ActiveRecord::Migration
  def up
    change_column :promotions, :position, :integer, null: false, :default => 0
  end

  def down
    change_column :promotions, :position, :integer, null: false, :default => nil
  end
end
