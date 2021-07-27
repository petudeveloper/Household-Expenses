require 'rails_helper'

RSpec.describe 'Profile Page', type: :system do
  before(:each) do
    User.create(name: 'user1', email: 'example@example.com', password: '123456')
  end

  it 'Login Page require' do
    visit root_path
    expect(page).to have_content('SIGN UP')
  end

  it 'denies access to unlogged' do
    visit "#{root_path}"
    expect(page).to_not have_content('New Expense')
  end

  it 'log in with name and password' do
    visit root_path
    fill_in 'Name', with: 'user1'
    fill_in 'Password', with: '123456'
    click_button 'LOG IN'
    expect(page).to have_content('Sign out')
  end

  it 'allows the user to sign up' do
    visit root_path
    click_link 'SIGN UP'
    fill_in 'Name', with: 'John Wick'
    fill_in 'Email', with: 'example2@example.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'SIGN UP'
    expect(page).to have_content('JOHN WICK')
  end

  it 'redirects to User Profile after successufully logged in.' do
    visit root_path
    fill_in 'Name', with: 'user1'
    fill_in 'Password', with: '123456'
    click_button 'LOG IN'
    expect(page).to have_content('All my expenses')
  end

  it 'permits the logged in user to logout' do
    visit root_path
    fill_in 'Name', with: 'user1'
    fill_in 'Password', with: '123456'
    click_button 'LOG IN'
    click_link 'Sign out'
    expect(page).to have_content('SIGN UP')
  end
end
