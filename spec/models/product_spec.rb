require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @category = Category.new(name: 'RSpec')
    @category.save
    @product = Product.new(name: "RSpec", price: 3500, quantity: 4, category: @category)
  end

  describe 'Validations' do 
    context "should propery save a new product" do
      it "should be saved" do
        @category = Category.new(name: 'RSpec')
        @category.save
        @product = Product.new(name: "RSpec", price: 3500, quantity: 4, category: @category)
        expect(@product.save).to eq(true)
      end
    end

    context " sould properly save a new product with name" do 
      it "should save the name and we can check it" do 
        productName = Product.new(name: nil, price: 3500, quantity: 4, category: @category)
        expect(productName.save).to be false
        p productName.errors.full_messages
      end
    end

    context "should save and include a price" do 
      it "should save with price" do 
        productPrice = Product.new(name: "RSpec", price: nil, quantity: 4, category: @category)
        productPrice.save
        expect(productPrice.price).to eq(nil)
        p productPrice.errors.full_messages
      end
    end

    context "should include a category" do 
      it "should be saved with a category" do 
        productCategory = Product.new(name: "RSpec", price: 3500, quantity: 4, category: nil)
        expect(productCategory.save).to be false
        p productCategory.errors.full_messages
      end
    end

    context "should fail and show errors" do 
      it "should not be " do 
        product2 = Product.new(name: nil, price: 3500, quantity: 1, category: @category)
        expect(product2.save).to be false
        p product2.errors.full_messages
      end
    end
  end
end

