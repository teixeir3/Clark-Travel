json.array!(@customers) do |customer|
  json.extract! customer, :id, :first_name, :last_name, :street, :city, :state, :zip, :home_phone, :alt_phone, :mobile_phone, :email, :birth_date
  json.url customer_url(customer, format: :json)
end
