require 'rails_helper'

RSpec.feature 'confirming users' do
  before do
    @user = User.new(email: 'user@example.com', password: 'password')
  end

  after do
    User.find_by_email('user@example.com').destroy!
  end

  scenario '', js: true do
    visit new_user_registration_path

    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    fill_in 'user_password_confirmation', with: @user.password

    click_button 'Sign up'

    open_email(@user.email)
    current_email.click_link('Confirm my account')

    expect(page.current_path).to eq(new_user_session_path)
  end
end