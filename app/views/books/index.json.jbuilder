json.array!(@books) do |book|
  json.extract! book, :id, :name, :picture
  json.url book_url(book, format: :json)
end
