require "rails_helper"

RSpec.describe CsvsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/csvs/new").to route_to("csvs#new")
    end

    it "routes to #show" do
      expect(get: "/csvs/1").to route_to("csvs#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/csvs/1/edit").to route_to("csvs#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/csvs").to route_to("csvs#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/csvs/1").to route_to("csvs#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/csvs/1").to route_to("csvs#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/csvs/1").to route_to("csvs#destroy", id: "1")
    end
  end
end
