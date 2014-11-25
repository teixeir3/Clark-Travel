class AddFacebookPublishAttr < ActiveRecord::Migration
  def change
    add_column :promotions, :facebook_publish, :boolean, null: false, default: false
    add_index :promotions, :facebook_publish
  end
end
