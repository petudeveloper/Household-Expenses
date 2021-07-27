require 'rails_helper'

RSpec.describe Group, type: :model do
    describe 'arguments validation ' do
        it 'rejects empty name' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        group1 = Group.new(name: '', user_id: user1.id)
        expect(group1.valid?).to eq(false)
        end

        it 'validates name' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        group1 = Group.new(name: 'Group1', user_id: user1.id)
        expect(group1.valid?).to eq(true)
        end

        it 'rejects with repeated name' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        Group.create(name: 'Group1', user_id: user1.id)
        group1 = Group.new(name: 'Group1', user_id: user1.id)
        expect(group1.valid?).to eq(false)
        end

        it 'rejects without user association' do
        group1 = Group.new(name: 'Group1')
        expect(group1.valid?).to eq(false)
        end
    end

    it 'deletes a group' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        group1 = Group.create!(name: 'Group1', user_id: user1.id)
        group1.delete
        expect(Group.all.count).to eq(0)
    end

    context 'as a collection for User model' do
        describe 'checks group arguments validations' do
            it 'rejects empty name' do
                user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
                group1 = user1.groups.build(name: '')
                expect(group1.valid?).to eq(false)
            end

            it 'validates name' do
                user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
                group1 = user1.groups.build(name: 'group1')
                expect(group1.valid?).to eq(true)
            end

            it 'rejects with repeated name' do
                user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
                user1.groups.create(name: 'group1')
                group1 = user1.groups.build(name: 'group1')
                expect(group1.valid?).to eq(false)
            end
        end

        it 'accesses all the groups associated to a user' do
        user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
        user1.groups.create(name: 'group1')
        user1.groups.create(name: 'group2')
        expect(user1.groups.count).to eq(2)
        end
    end

    context 'as a collection for Expense model' do
        describe 'checks group validations' do
            it 'rejects empty' do
                user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
                expense1 = user1.expenses.create(name: 'expense1', amount: 4)
                group1 = expense1.groups.build(user_id: user1.id)
                expect(group1.valid?).to eq(false)
            end

            it 'validates name' do
                user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
                expense1 = user1.expenses.create(name: 'expense1', amount: 4)
                group1 = expense1.groups.build(name: 'group1', user_id: user1.id)
                expect(group1.valid?).to eq(true)
            end

            it 'rejects repeated name' do
                user1 = User.create!(name: 'John Wick', email: 'example@example.com', password: '123456')
                user1.groups.create(name: 'group1')
                expense1 = user1.expenses.create(name: 'expense1', amount: 4)
                group1 = expense1.groups.build(name: 'group1', user_id: user1.id)
                expect(group1.valid?).to eq(false)
            end
        end
    end
end