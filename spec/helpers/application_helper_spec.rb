require 'spec_helper'

describe ApplicationHelper do

  describe "#full_title" do
    it "includes the page title" do
      expect(full_title("Title")).to match(/Title/)
    end

    it "includes the base title" do
      expect(full_title("Title")).to match(/\AMagic App/)
    end

    it "doesn't include a bar for home page" do
      expect(full_title("")).not_to match(/\|/)
    end
  end
end
