json.array!(@procurements) do |procurement|
  json.extract! procurement, :id, :name, :proc_start_date, :proc_end_date, :proc_terms, :proc_delivery_date
  json.url procurement_url(procurement, format: :json)
end
