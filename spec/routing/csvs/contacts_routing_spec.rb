require "rails_helper"

RSpec.describe Csvs::ContactsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/csvs/1/contacts").to route_to("csvs/contacts#index", csv_id: "1")
    end

    it "routes to #create" do
      expect(post: "/csvs/1/contacts").to route_to("csvs/contacts#create", csv_id: "1")
    end
  end
end
