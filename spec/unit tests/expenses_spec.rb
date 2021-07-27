require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'checks expense validations' do
    it 'rejects empty name' do
      user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
      expense1 = Expense.new(name: '', user_id: user1.id, amount: 400)
      expect(expense1.valid?).to eq(false)
    end

    it 'validates name' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        expense1 = Expense.new(name: 'expense1', user_id: user1.id, amount: 400)
      expect(expense1.valid?).to eq(true)
    end

    it 'validates repeated name' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        Expense.create(name: 'expense1', user_id: user1.id, amount: 400)
      expense1 = Expense.new(name: 'expense1', user_id: user1.id, amount: 800)
      expect(expense1.valid?).to eq(true)
    end

    it 'rejects without author' do
        expense1 = Expense.new(name: 'expense1', amount: 800)
        expect(expense1.valid?).to eq(false)
    end

    it 'rejects if amount is not number' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        expense1 = Expense.new(name: 'expense1', user_id: user1.id, amount: 'two')
        expect(expense1.valid?).to eq(false)
    end
  end

  it 'deletes a expense' do
    user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
    expense1 = Expense.create!(name: 'expense1', user_id: user1.id, amount: 400)
    expense1.delete
    expect(Expense.all.count).to eq(0)
  end

  describe 'checks expense validations' do
    it 'rejects empty name for updating' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        expense1 = Expense.create!(name: 'expense1', user_id: user1.id, amount: 400)
        expense1.update(name: '')
        expect(expense1.valid?).to eq(false)
    end

    it 'rejects empty user_id for expense updating' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        expense1 = Expense.create!(name: 'expense1', user_id: user1.id, amount: 400)
        expense1.update(user_id: '')
      expect(expense1.valid?).to eq(false)
    end

    it 'rejects updating amount is not number' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        expense1 = Expense.create!(name: 'expense1', user_id: user1.id, amount: 400)
        expense1.update(amount: '')
      expect(expense1.errors.full_messages).to eq(['Amount can\'t be blank', 'Amount is not a number'])
    end

    it 'validates updating with valid inputs' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        expense1 = Expense.create!(name: 'expense1', user_id: user1.id, amount: 400)
        user2 = User.create!(name: 'John smith', email: 'example2@example.com', password: '123456')
      expense1.update(name: 'expense1', user_id: user2.id, amount: 5)
      expect(expense1.valid?).to eq(true)
    end
  end

  context 'as a collection for User model' do
    describe 'checks expense arguments validations' do
      it 'rejectsempty name' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        expense1 = user1.expenses.build(amount: 1)
        expect(expense1.valid?).to eq(false)
      end

      it 'rejects empty amount' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        expense1 = user1.expenses.build(name: 'expense1')
        expect(expense1.valid?).to eq(false)
      end

      it 'validates inputs' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        expense1 = user1.expenses.build(name: 'expense1', amount: 400)
        expect(expense1.valid?).to eq(true)
      end
    end

    it 'accesses expenses associated to a user' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        user1.expenses.create(name: 'expense1', amount: 400)
        user1.expenses.create(name: 'expense2', amount: 5)
      expect(user1.expenses.count).to eq(2)
    end
  end

  context 'as a collection for Group model' do
    describe 'checks expense validations' do
      it 'rejects empty name' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        group1 = user1.groups.create!(name: 'Dairy')
        expense1 = group1.expenses.build(user_id: user1.id, amount: 400)
        expect(expense1.valid?).to eq(false)
      end

      it 'rejects empty author' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        group1 = user1.groups.create!(name: 'Dairy')
        expense1 = group1.expenses.build(name: 'expense1', amount: 400)
        expect(expense1.valid?).to eq(false)
      end

      it 'rejects empty amount' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        group1 = user1.groups.create!(name: 'Dairy')
        expense1 = group1.expenses.build(name: 'expense1', user_id: user1.id)
        expect(expense1.valid?).to eq(false)
      end

      it 'validates inputs' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        group1 = user1.groups.create!(name: 'Dairy')
        expense1 = group1.expenses.build(name: 'expense1', user_id: user1.id, amount: 400)
        expect(expense1.valid?).to eq(true)
      end
    end
  end
end