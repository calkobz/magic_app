require 'spec_helper'

def sign_in_user
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it_behaves_like "all pages", "Sign in"
    it_behaves_like "signed out navbars"
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title("Sign in") }
      it { should have_selector(:css, 'div.alert-box.alert') }

      describe "after visiting another page" do
        before { click_link "My App" }
        it { should_not have_selector('div.alert-box.alert') }
      end

    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        visit signin_path
        sign_in_user
      end

      it { should have_title(user.name) }
      it_behaves_like "signed in navbars"

      describe "followed by signout" do
        before { click_link "Sign out" }
        it_behaves_like "signed out navbars"
      end

    end
  end
end
