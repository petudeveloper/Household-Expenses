require 'rails_helper'

RSpec.describe 'Groups Pages', type: :system do
  before(:each) do
    author1 = User.create!(name: 'User001', email: 'example3@example.com', password: '123456')
    group1 = author1.groups.create!(name: 'Group 1', icon: '')
    group2 = author1.groups.create!(name: 'Group 2', icon: '')
    expense1 = author1.expenses.create!(name: 'Expense 1', amount: 4)
    expense2 = author1.expenses.create!(name: 'Expense 2', amount: 8)
    expense3 = author1.expenses.create!(name: 'Expense 3', amount: 2)
    expense1.groups << group1
    expense2.groups << group2
    expense3.groups << group2
  end

  it 'allows user to see all groups on \'All groups\' Page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    fill_in 'Password', with: '123456'
    click_button 'LOG IN'
    click_link 'All groups'
    expect(page).to have_content('Group 2')
  end

  it 'allows user to see all expenses from a group' do
    visit root_path
    fill_in 'Name', with: 'User001'
    fill_in 'Password', with: '123456'
    click_button 'LOG IN'
    click_link 'All groups'
    click_link 'Group 2'
    expect(page).to have_content('Expense 2')
  end

  it 'allows user to access the \'New Group\' form Page' do
    visit root_path
    fill_in 'Name', with: 'User001'
    fill_in 'Password', with: '123456'
    click_button 'LOG IN'
    click_link 'All groups'
    click_link 'New Group'
    expect(page).to have_content('New Group')
  end

  it 'allows user to create a new group' do
    visit root_path
    fill_in 'Name', with: 'User001'
    fill_in 'Password', with: '123456'
    click_button 'LOG IN'
    click_link 'All groups'
    click_link 'New Group'
    fill_in 'name', with: 'Group 3'
    click_button 'SUBMIT'
    expect(page).to have_content('Your group was successfully created.')
  end
end
