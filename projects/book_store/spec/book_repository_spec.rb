require 'books'
require 'books_repository'

RSpec.describe Book do
  it 'shows books from the list' do
    books = repo.all
    books.length => 2
    books.first.id => 1
    books.first.title => 'Nineteen Eighty-Four'
    books.last.author_name => 'Edith Wharton'
  end
end