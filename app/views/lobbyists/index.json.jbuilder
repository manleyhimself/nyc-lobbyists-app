json.array!(@lobbyists) do |lobbyist|
  json.extract! lobbyist, :name, :firm_id
  json.url lobbyist_url(lobbyist, format: :json)
end
