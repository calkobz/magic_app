require 'spec_helper'

feature "static_pages" do
  subject { page }

  feature "Navbar" do
    scenario "clicking on links leads to the correct page" do
      visit root_path
      click_link "About"
      expect(page).to have_title(full_title("About"))
      click_link "My App"
      expect(page).to have_title(full_title(""))
    end
  end

  feature "Home page" do
    before { visit root_path }

    it_behaves_like "all pages", ""
    it_behaves_like "pages with navbar"
  end

  feature "About page" do
    before { visit about_path }

    it_behaves_like "all pages", "About"
    it_behaves_like "pages with navbar"
  end

end
