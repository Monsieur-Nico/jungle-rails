require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do 

    context "Should fail to create if no password present" do
      it "should fail to create when only password confirmation is present" do 
        exampleNoPassword = User.new(first_name: "No", last_name: 'Password', email: 'example@example.com', password: nil, password_confirmation: "example")
        expect(exampleNoPassword.save).to be false 
        p exampleNoPassword.errors.full_messages
      end
    end

    context 'Should fail to create if no password confirmation present' do
      it "should fail to create when only password is present" do 
        exampleNoPasswordConfirmation = User.new(first_name: "example", last_name: 'example', email: 'example@example.com', password: 'example', password_confirmation: nil)
        expect(exampleNoPasswordConfirmation.save).to be false
        p exampleNoPasswordConfirmation.errors.full_messages
      end
    end
    
    it "should fail to save when password and password_confirmation is not the same" do 
      passwordAndConfirmationDifferent = User.new(first_name: 'example', last_name: "example", email: "example@example.com", password: "example", password_confirmation: "exampl")
      expect(passwordAndConfirmationDifferent.save).to be false 
      p passwordAndConfirmationDifferent.errors.full_messages
    end

    it "should fail to save if email already exists" do 
      example1 = User.new(first_name: 'example', last_name: "example", email: "example@example.com", password: "example", password_confirmation: "example")
      example1.save
      example2 = User.new(first_name: 'example', last_name: "example", email: "example@example.com", password: "example", password_confirmation: "example")
      expect(example2.save).to be false
      p example2.errors.full_messages
    end

    it "should fail to save if firts_name is not present" do 
      example = User.new(first_name: nil, last_name: "example", email: "example@example.com", password: "example", password_confirmation: "example")
      expect(example.save).to be false
      p example.errors.full_messages
    end

    it "should fail to save if email is the same but with different Case sensitivity" do 
      example1 = User.new(first_name: 'example', last_name: "example", email: "example@example.com", password: "example", password_confirmation: "example")
      example1.save
      example2 = User.new(first_name: 'example', last_name: "example", email: "EXAMPLE@EXAMPLE.COM", password: "example", password_confirmation: "example")
      expect(example2.save).to be false
      p example2.errors.full_messages
   end

    it "should fail to save if last_name is not present" do 
      example = User.new(first_name: "example", last_name: nil, email: "example@example.com", password: "example", password_confirmation: "example")
      expect(example.save).to be false
      p example.errors.full_messages
    end

    it "should authenticate user if password is correct" do
      example = User.new(first_name: "example", last_name: 'example', email: "example@example.com", password: "example", password_confirmation: "example")
      example.save 
      expect(User.authenticate_with_credentials("example@example.com", "example")).to eq(example)
    end

    it "should fail to save if Password smaller than 3 characters" do 
      example = User.new(first_name: "example", last_name: "example", email: "example@example.com", password: "ex", password_confirmation: "ex")
      expect(example.save).to be false
      p example.errors.full_messages
    end

    it "should login even if users have different cases in their email" do
      example = User.new(first_name: "example", last_name: "example", email: "example@example.com", password: "example", password_confirmation: "example")
      example.save 
      expect(User.authenticate_with_credentials(" ExaMpLe@ExAmPlE.cOm ", "example")).to eq(example)
    end

    it "should authenticate with spaces in the email" do
      example = User.new(first_name: "example", last_name: 'example', email: "example@example.com", password: "example", password_confirmation: "example")
      example.save 
      expect(User.authenticate_with_credentials(" example@example.com ", "example")).to eq(example)
    end

  end
end
