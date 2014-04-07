json.array!(@books) do |book|
  json.extract! book, :id, :title, :author, :publisher, :publish_date, :price, :amazon_link
  json.url book_url(book, format: :json)
end
