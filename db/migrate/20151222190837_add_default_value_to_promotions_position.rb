class AddDefaultValueToPromotionsPosition < ActiveRecord::Migration
  def change
    change_column_null :promotions, :position, false, default: 0
  end
end
