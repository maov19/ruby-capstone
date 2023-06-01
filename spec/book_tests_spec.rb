require_relative '../book_app'
require_relative '../book'
require_relative '../label'

RSpec.describe Book do
  describe '#can_be_archived?' do
    context 'when cover state is "good" and publish date is 5 years ago' do
      it 'returns false' do
        book = Book.new('Test Book', Date.today - (5 * 365), 'Test Publisher', 'good')
        expect(book.can_be_archived?).to be(false)
      end
    end

    context 'when cover state is "bad"' do
      it 'returns true' do
        book = Book.new('Test Book', Date.today, 'Test Publisher', 'bad')
        expect(book.can_be_archived?).to eq(true)
      end
    end
  end
end
