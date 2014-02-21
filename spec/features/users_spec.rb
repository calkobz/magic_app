require 'spec_helper'

def fill_in_signup
  within('#signup') do
    fill_in 'Name', with: "exampleuser"
    fill_in 'Email', with: "exampleuser@example.com"
    fill_in 'Password', with: "foobar"
    fill_in 'Confirm Password', with: "foobar"
  end
end

feature "user actions" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:submit) { 'Create account' }

  feature "signing up" do

    before :each do
      visit signup_path
    end

    it_behaves_like "all pages", "Sign up"
    it_behaves_like "signed out navbars"

    scenario "with valid information" do
      fill_in_signup

      expect { click_button submit }.to change(User, :count).by(1)
    end

    scenario "after saving the user" do
      fill_in_signup

      click_button submit
      expect(page).to have_title("exampleuser")
      expect(page).to have_selector('div', text: 'Welcome')
      it_behaves_like "signed in navbars"
    end

    scenario "with no information" do
      expect { click_button submit }.not_to change(User, :count)
    end

    scenario "with invalid information" do
      click_button submit

      expect(page).to have_title 'Sign up'
      expect(page).to have_content 'error'
    end

  end

  feature "visiting profile page" do
    before { visit user_path(user) }

    # it_behaves_like "pages with navbar"
    it { should have_title user.name }
    it { should have_content user.email }
  end
end
