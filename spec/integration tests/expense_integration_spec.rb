require 'rails_helper'

RSpec.describe 'Expenses Pages', type: :system do
  before(:each) do
    author1 = User.create!(name: 'User001', email: 'example3@example.com', password: '123456')
    expense1 = author1.expenses.create!(name: 'Expense 1', amount: 4)
    group1 = author1.groups.create!(name: 'Group 1', icon: "")
    expense1.groups << group1
    author1.expenses.create(name: 'Expense 2', amount: 8)
    author1.expenses.create(name: 'Expense 3', amount: 2)
  end

  it 'allows user to see all their expenses on \'All my expenses\' Page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    fill_in 'Password', with: '123456'
    click_button 'LOG IN'
    click_link 'All my expenses'
    expect(page).to have_content('Expense 1')
  end

  it 'allows user to see only their external expenses' do
    visit root_path
    fill_in 'Name', with: 'User001'
    fill_in 'Password', with: '123456'
    click_button 'LOG IN'
    click_link 'All my external transactions'
    expect(page).to have_content('Expense 3')
  end

  it 'allows user to access the \'new expense\' form page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    fill_in 'Password', with: '123456'
    click_button 'LOG IN'
    click_link 'All my expenses'
    click_link 'New Expense'
    expect(page).to have_content('New Expense')
  end

  it 'allows user to create a new expense' do
    visit root_path
    fill_in 'Name', with: 'User001'
    fill_in 'Password', with: '123456'
    click_button 'LOG IN'
    click_link 'All my expenses'
    click_link 'New Expense'
    fill_in 'name', with: 'Expense 4'
    fill_in 'amount', with: 5
    page.check('Group 1')
    click_button 'CREATE EXPENSE'
    expect(page).to have_content('Your expense was successfully created.')
  end
end