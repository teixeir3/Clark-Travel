class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.string :home_phone
      t.string :alt_phone
      t.string :mobile_phone
      t.string :email
      t.date :birth_date

      t.timestamps
    end
  end
end
