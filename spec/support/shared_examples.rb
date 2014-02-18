shared_examples_for "all pages" do |page_title|
  it { should have_title(full_title(page_title)) }
end

shared_examples_for "pages with navbar" do
  it { should have_selector('nav.top-bar') }
  it { should have_link("My App") }
  it { should have_link("About") }
  it { should have_link("Sign up") }
end
