require 'rails_helper'

# RSpec.describe Product, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should be valid' do
      @category = Category.new(
          name: "fabric"
      )
      @product = @category.products.new(
          name: "magic pants",
          quantity: 10,
          price: 100
      )
      expect(@product).to be_valid

    end

    it 'name cannot be blank' do
      @category = Category.new(
        name: "fabric"
      )
      @product = @category.products.new(
        name: nil,
        quantity: 10,
        price: 100
      )
    expect(@product).to be_valid
    end

    it 'quantity cannot be blank' do
      @category = Category.new(
        name: "fabric"
      )
      @product = @category.products.new(
        name: "magic pants",
        quantity: nil,
        price: 40
      )
    expect(@product).to be_valid
    end

    it 'price cannot be nil' do
      @category = Category.new(
        name: "fabric"
      )
      @product = @category.products.new(
        name: "magic pants",
        quantity: 10,
        price: nil
      )
    expect(@product).to be_valid
    end

    it 'category name cannot be nil' do
      @product = Products.new(
        name: "magic pants",
        quantity: 10,
        price: 40,
        category: nil
      )
    expect(@product).to be_valid
    end
    # puts product.errors.full_messages
    # puts (@product).errors.full_messages
  end
end