json.array!(@agencies) do |agency|
  json.extract! agency, :name, :address, :description
  json.url agency_url(agency, format: :json)
end
