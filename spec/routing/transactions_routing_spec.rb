require "rails_helper"

RSpec.describe TransactionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/transactions").to route_to("transactions#index")
    end

    it "routes to #show" do
      expect(get: "/transactions/1").to route_to("transactions#show", id: "1")
    end

    it "routes to #create - transfer" do
      expect(post: "/transactions/transfer").to route_to("transactions#create", transaction_type: 'transfer')
    end

    it "routes to #create - credit card" do
      expect(post: "/transactions/credit_card").to route_to("transactions#create", transaction_type: 'credit_card')
    end

    it "routes to #update via PUT" do
      expect(put: "/transactions/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "/transactions/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/transactions/1").not_to be_routable
    end
  end
end
