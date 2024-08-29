require 'sinatra'
require 'json'

# Initial data (mock database)
books = [
  { id: 1, title: 'The Hobbit', author: 'J.R.R. Tolkien' },
  { id: 2, title: '1984', author: 'George Orwell' },
  { id: 3, title: 'Sherlock Holmes', author: 'Arthur Conan Doyle' }
]

# GET /books - Return all books
# curl -X GET http://localhost:4567/books
get '/books' do
  content_type :json
  books.to_json
end

# GET /books/:id - Return a single book by ID
# curl -X GET http://localhost:4567/books/5
get '/books/:id' do
  content_type :json
  book = books.find { |b| b[:id] == params[:id].to_i }
  if book
    book.to_json
  else
    halt 404, { message: 'Book Not Found' }.to_json
  end
end

# POST /books - Add a new book
# curl -X PUT http://localhost:4567/books -d "title=Algebra" -d "author=Vadym"
post '/books' do
  content_type :json
  new_book = {
    id: books.size + 1,
    title: params[:title],
    author: params[:author]
  }
  books << new_book
  new_book.to_json
end

# PUT /books/:id - Update a book by ID
# curl -X PUT http://localhost:4567/books/5 -d "title=English Class" -d "author=Vadym"
put '/books/:id' do
  content_type :json
  book = books.find { |b| b[:id] == params[:id].to_i }
  if book
    book[:title] = params[:title] if params[:title]
    book[:author] = params[:author] if params[:author]
    book.to_json
  else
    halt 404, { message: 'Book Not Found' }.to_json
  end
end

# DELETE /books/:id - Delete a book by ID
# curl -X DELETE http://localhost:4567/books/5
delete '/books/:id' do
  content_type :json
  book = books.find { |b| b[:id] == params[:id].to_i }
  if book
    books.delete(book)
    { message: 'Book Deleted' }.to_json
  else
    halt 404, { message: 'Book Not Found' }.to_json
  end
end