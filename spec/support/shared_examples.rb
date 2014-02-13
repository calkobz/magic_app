shared_examples_for "all static pages" do |page_title, heading|
  it { should have_title(page_title) }
  it { should have_selector('h1', text: heading) }
end
