json.array!(@firms) do |firm|
  json.extract! firm, :name, :address
  json.url firm_url(firm, format: :json)
end

