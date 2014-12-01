class AddDisplayToUser < ActiveRecord::Migration
  def change
    add_column :users, :display, :boolean, null: false, default: true
    add_index :users, :display
  end
end
