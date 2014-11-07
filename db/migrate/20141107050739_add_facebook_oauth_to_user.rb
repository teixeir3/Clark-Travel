class AddFacebookOauthToUser < ActiveRecord::Migration
  def change
    add_column :user, :provider, :string
    add_column :user, :uid, :string
    add_column :user, :oauth_token, :string
    add_column :user, :oauth_expires_at, :datetime
  end
end
