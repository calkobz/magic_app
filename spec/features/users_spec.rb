require 'spec_helper'

feature "user actions" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:submit) { 'Create account' }

  feature "signing up" do

    before { visit signup_path }
    it_behaves_like "all pages", "Sign up"
    it_behaves_like "pages with navbar"

    scenario "with valid information" do
      visit signup_path

      within('#signup') do
        fill_in 'Name', with: user.name
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        fill_in 'Confirm Password', with: 'foobar'
      end

      expect { click_button submit }.to change(User, :count).by(1)
    end

    scenario "with no information" do
      visit signup_path
      expect { click_button submit }.not_to change(User, :count)
    end
  end

  feature "visiting profile page" do
    before { visit user_path(user) }

    it_behaves_like "pages with navbar"
    it { should have_title(user.name) }
    it { should have_content(user.email) }
  end
end
