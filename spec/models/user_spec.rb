require 'rails_helper'

# it must be created with a password and password_confirmation fields
# TEST@TEST.com should not be allowed if test@test.COM

RSpec.describe User, type: :model do
  describe 'testing -' do

    it 'all valid (1)' do
      @user = User.new(first_name: 'David',
                       last_name: 'Test',
                       email: 'test@test.com',
                       password: 'password',
                       password_confirmation: 'password')
      expect(@user.valid?).to be true
    end

    it 'password does not meet minimum length (2)' do
    @user = User.new(first_name: 'David',
                     last_name: 'Test',
                     email: 'test@test.com',
                     password: '123')
    expect(@user.valid?).to be false
    expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
  end

    it 'passwords do not match (3)' do
      @user = User.new(first_name: 'David',
                       last_name: 'Test',
                       email: 'test@test.com',
                       password: 'password',
                       password_confirmation: '123456')
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("password confirmation doesn't match password")
    end

    it 'case sensitivity for email (4)' do
      @user1 = User.new(first_name: 'David',
                        last_name: 'Test',
                        email: 'test@test.com',
                        password: 'password',
                        password_confirmation: 'password')
      @user1.save
      @user2 = User.new(first_name: 'David',
                        last_name: 'Test',
                        email: 'Test@test.com',
                        password: 'password',
                        password_confirmation: 'password')
      expect(@user2.save).to be false
      expect(@user2.errors.full_messages).to include("email has already been taken")
    end

    it 'first name is not included (5)' do
      @user = User.new(last_name: 'Test',
                       email: 'test@test.com',
                       password: 'password',
                       password_confirmation: 'password')
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("first name can't be blank")
    end

    it 'last name is not included (6)' do
      @user = User.new(first_name: 'Test',
                       email: 'test@test.com',
                       password: 'password',
                       password_confirmation: 'password')
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("last name can't be blank")
    end

    it 'email is not included (7)' do
      @user = User.new(last_name: 'Test',
                       first_name: 'test@test.com',
                       password: 'password',
                       password_confirmation: 'password')
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("email can't be blank")
    end

  end

  describe '.authenticate_with_credentials' do
    it 'Valid credentials (8)' do
      @user = User.new(
        first_name: 'David',
        last_name: 'Test',
        email: 'd@gmail.com',
        password: 'password',
        password_confirmation: 'password')
    @user.save
    expect(User.authenticate_with_credentials(@user.email, @user.password)).to be_truthy
    end

    it 'white spaces with the email (9)' do
      @user = User.new(first_name: 'David',
                       last_name: 'Test',
                       email: 'test@test.com',
                       password: 'password',
                       password_confirmation: 'password')
      @user.save
      expect(User.authenticate_with_credentials('test@test.com ',@user.password)).to be_truthy
    end

    it 'different cases with the email (10)' do
      @user = User.new(first_name: 'David',
                       last_name: 'Test',
                       email: 'test@test.com',
                       password: 'password',
                       password_confirmation: 'password')
      @user.save
      expect(User.authenticate_with_credentials('TesT@TesT.com',@user.password)).to be_truthy
    end

    end

end
