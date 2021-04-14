require "rails_helper"

RSpec.describe Users::ContactsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/users/contacts").to route_to("users/contacts#index")
    end
  end
end
