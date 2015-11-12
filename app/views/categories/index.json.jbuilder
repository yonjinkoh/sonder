json.array!(@categories) do |category|
  json.extract! category, :id, :name, :api
  json.url category_url(category, format: :json)
end
