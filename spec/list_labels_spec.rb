require_relative '../book_app'
require_relative '../book'
require_relative '../label'
require 'date'
require 'json'

RSpec.describe BookActions do
  before do
    @book_app = BookActions.new(file: './data/books.json')
  end

  describe '#list book' do
    before do
      allow(@book_app).to receive(:gets).and_return(
        'another title',
        'another publisher',
        'b',
        '1119-11-11',
        'gift',
        'blue'
      )
    end

    it 'includes the folowing info in the output data after adding a label' do
      @book_app.add_book
      expect { @book_app.list_labels }.to output(include('gift')).to_stdout
      expect { @book_app.list_labels }.to output(include('blue')).to_stdout
    end
  end
end
