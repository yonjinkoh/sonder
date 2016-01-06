json.array!(@places) do |place|
  json.extract! place, :id, :name, :type, :description, :id, :position, :list_id, :picture
  json.url place_url(place, format: :json)
end
