require "rails_helper"

RSpec.describe AccountsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/accounts").to route_to("accounts#index")
    end

    it "routes to #show" do
      expect(get: "/accounts/1").to route_to("accounts#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/accounts").to route_to("accounts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/accounts/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "/accounts/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/accounts/1").not_to be_routable
    end
  end
end
