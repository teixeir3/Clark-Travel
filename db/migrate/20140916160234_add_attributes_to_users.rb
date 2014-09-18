class AddAttributesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :position, :int
    add_column :users, :title, :string
    add_column :users, :bio, :text
    add_column :users, :work_phone, :string
    add_column :users, :home_phone, :string
    add_column :users, :mobile_phone, :string
    add_column :users, :fax, :string
  end
end
