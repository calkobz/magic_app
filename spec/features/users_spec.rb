require 'spec_helper'

feature "signing up" do

  subject { page }

  before { visit signup_path }
  it_behaves_like "all pages", "Sign up"
  it_behaves_like "pages with navbar"

  scenario "with valid information" do
    visit signup_path

    # within('#signup') do
    #   fill_in 'Username', with: 'Some User'
    #   fill_in 'Email', with: 'user@example.com'
    #   fill_in 'Password', with: 'foobar'
    #   fill_in 'Verify Password', with: 'foobar'
    # end

    # click_link 'Sign up'
    # expect(page).to have_content 'Success'

  end
end
