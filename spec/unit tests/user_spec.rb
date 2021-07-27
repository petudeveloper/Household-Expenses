require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'checks user validations' do
    it 'rejects empty name' do
      user1 = User.new(name: '')
      expect(user1.valid?).to eq(false)
    end

    it 'validates user name' do
      user1 = User.new(name: 'John Wick', email: 'example@example.com', password: '123456')
      expect(user1.valid?).to eq(true)
    end

    it 'rejects creation with repeated name' do
      User.create(name: 'John Wick')
      user1 = User.new(name: 'John Wick')
      expect(user1.valid?).to eq(false)
    end
  end

  it 'deletes a user' do
    user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
    user1.delete
    expect(User.all.count).to eq(0)
  end

  describe 'Validation for updating' do
    it 'rejects empty name' do
      user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
      user1.update(name: '')
      expect(user1.valid?).to eq(false)
    end

    it 'valid name' do
      user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
      user1.update(name: 'John Smith')
      expect(user1.valid?).to eq(true)
    end
  end
end
