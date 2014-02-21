shared_examples_for "all pages" do |page_title|
  it { should have_title(full_title(page_title)) }
end

shared_examples_for "all navbars" do
  it { should have_selector('nav.top-bar') }
  it { should have_link("My App") }
  it { should have_link("About") }
end

shared_examples_for "signed out navbars" do
  it_behaves_like "all navbars"
  it { should have_link("Sign up") }
  it { should have_link("Sign in") }
  it { should_not have_link("Profile") }
  it { should_not have_link("Sign out") }
end

shared_examples_for "signed in navbars" do
  it_behaves_like "all navbars"
  it { should have_link("Sign out") }
  it { should have_link("Profile") }
  it { should_not have_link("Sign up") }
  it { should_not have_link("Sign in") }
end
