json.array!(@shows) do |show|
  json.extract! show, :id, :position, :name, :description, :picture, :list_id
  json.url show_url(show, format: :json)
end
