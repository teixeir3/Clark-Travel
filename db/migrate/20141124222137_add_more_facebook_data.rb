class AddMoreFacebookData < ActiveRecord::Migration
  def change
    add_column :users, :fb_image_url, :string
  end
end
