require_relative '../book_app'
require_relative '../book'
require_relative '../label'
require 'date'
require 'json'

RSpec.describe BookActions do
  before do
    @book_app = BookActions.new(file: '../data/books.json')
  end

  it 'is an instance of the Book class' do
    expect(@book_app).to be_instance_of(BookActions)
  end

  describe '#add_book' do
    before do
      allow(@book_app).to receive(:gets).and_return(
        'Test title',
        'publisher one',
        'b',
        '2023-05-31',
        'gift',
        'red'
      )
    end

    it 'adds the correct book data into the book' do
      @book_app.add_book
      book = @book_app.books.last
      expect(book.title).to eq('Test title')
      expect(book.publisher).to eq('publisher one')
      expect(book.publish_date).to eq(Date.parse('2023-05-31'))
      expect(book.publisher).to eq('publisher one')
      expect(book.cover_state).to eq('bad')
    end
  end
end
