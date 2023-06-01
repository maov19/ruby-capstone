require_relative '../item'
require_relative '../author'

RSpec.describe Author do
  let(:author) { Author.new }

  describe '#initialize' do
    it 'creates an author with default unknown names' do
      expect(author.first_name).to eq('Unknown')
      expect(author.last_name).to eq('Unknown')
    end

    it 'generates a random ID for the author' do
      expect(author.instance_variable_get(:@id)).to be_an(Integer)
    end

    it 'initializes an empty array of items' do
      expect(author.items).to eq([])
    end
  end

  describe '#add_item' do
    let(:item) { Item.new('Game') }

    it 'adds the item to the author\'s collection of items' do
      author.add_item(item)
      expect(author.items).to include(item)
    end

    it 'sets the author of the item to self' do
      author.add_item(item)
      expect(item.author).to eq(author)
    end

    it 'does not add the same item again' do
      author.add_item(item)
      author.add_item(item)
      expect(author.items.count(item)).to eq(1)
    end
  end
end
