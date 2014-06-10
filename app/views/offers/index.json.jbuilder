json.array!(@offers) do |offer|
  json.extract! offer, :id, :offer_technical, :offer_economical, :delivery_date
  json.url offer_url(offer, format: :json)
end
