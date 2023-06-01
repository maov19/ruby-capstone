require_relative '../book_app'
require_relative '../book'
require_relative '../label'
require 'date'

RSpec.describe Label do
  before :each do
    @label = Label.new(1, 'label test', 'green')
    @book = Book.new('book title', '2023-05-31', 'publisher test', 'good')
  end

  it 'is an instance of the Book class' do
    expect(@label).to be_instance_of(Label)
  end

  it 'has a name attribute' do
    expect(@label.name).to eq('label test')
  end

  it 'can add an item to its collection' do
    @label.add_item(@book)
    expect(@label.items).to include(@book)
  end

  it 'adds itself as the item\'s label' do
    @label.add_item(@book)
    expect(@book.label).to eq(@label)
  end

  it 'adds the item to its items collection' do
    @label.add_item(@book)
    expect(@label.items).to include(@book)
  end
end
