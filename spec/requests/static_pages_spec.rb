# require 'spec_helper'
# 
# describe "StaticPages" do
# 
#   subject { page }
# 
#   describe "Home page" do
#     before { visit '/static_pages/home' }
#     let(:heading) { 'Magic App' }
#     let(:page_title) { 'Magic App' }
# 
#     it_should_behave_like "all static pages"
#     it { should_not have_title("| Home") }
#   end
# 
#   describe "Help page" do
#     before { visit '/static_pages/help' }
#     let(:heading) { 'Help' }
#     let(:page_title) { 'Magic App | Help' }
# 
#     it_should_behave_like "all static pages"
#   end
# end
