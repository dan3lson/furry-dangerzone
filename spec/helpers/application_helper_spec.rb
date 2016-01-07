require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe "#full_header" do
    it "returns blank as the default string" do
      expect(full_header("")).to eq("")
    end
    it "returns the argument as appended to the \'Leksi | \' string" do
      expect(full_header("Welcome")).to eq("Welcome")
    end
  end
end
