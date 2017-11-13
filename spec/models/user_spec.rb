require 'rails_helper'

# it must be created with a password and password_confirmation fields
# TEST@TEST.com should not be allowed if test@test.COM

RSpec.describe User, type: :model do

    it 'all valid (1)' do
      @user = User.new(first_name: 'David',
                       last_name: 'Test',
                       email: 'test@test.com',
                       password_digest: 'password',
                       password_confirmation: 'password')
      expect(@user.valid?).to be true
    end

    it 'password does not meet minimum length (2)' do
    @user = User.new(first_name: 'David',
                     last_name: 'Test',
                     email: 'test@test.com',
                     password_digest: '123')
    expect(@user.valid?).to be false
    # expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
  end

    it 'passwords do not match (3)' do
      @user = User.new(first_name: 'David',
                       last_name: 'Test',
                       email: 'test@test.com',
                       password_digest: 'password',
                       password_confirmation: '123456')
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'case sensitivity for email (4)' do
      @user1 = User.new(first_name: 'David',
                        last_name: 'Test',
                        email: 'test@test.com',
                        password_digest: 'password',
                        password_confirmation: 'password')
      @user1.save
      @user2 = User.new(first_name: 'David',
                        last_name: 'Test',
                        email: 'Test@test.com',
                        password_digest: 'password',
                        password_confirmation: 'password')
      expect(@user2.save).to be false
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'first name is not included (5)' do
      @user = User.new(last_name: 'Test',
                       email: 'test@test.com',
                       password_digest: 'password',
                       password_confirmation: 'password')
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'last name is not included (6)' do
      @user = User.new(first_name: 'Test',
                       email: 'test@test.com',
                       password_digest: 'password',
                       password_confirmation: 'password')
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'email is not included (7)' do
      @user = User.new(last_name: 'Test',
                       first_name: 'test@test.com',
                       password_digest: 'password',
                       password_confirmation: 'password')
      expect(@user.valid?).to be false
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

end
