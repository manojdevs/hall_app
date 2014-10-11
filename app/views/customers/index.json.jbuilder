json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :mobile, :address, :check_in_date, :no_of_days, :room_type
  json.url customer_url(customer, format: :json)
end
