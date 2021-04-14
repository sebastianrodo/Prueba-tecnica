require "rails_helper"

RSpec.describe Users::CsvsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/users/csvs").to route_to("users/csvs#index")
    end
  end
end
