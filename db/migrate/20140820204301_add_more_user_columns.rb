class AddMoreUserColumns < ActiveRecord::Migration
  def change
    add_attachment :users, :avatar
    add_column :users, :password_reset_token, :string
    add_column :users, :password_reset_sent_at, :datetime
    add_column :users, :is_active, :boolean, null: false, default: false
    add_column :users, :activation_token, :string, null: false, default: "INACTIVE"
    add_column :users, :uid, :string
    add_column :users, :access_token, :string
    add_column :users, :provider, :string
  end
end
