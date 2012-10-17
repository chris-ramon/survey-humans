require "spec_helper"

describe Panel::SubscriptionsController do
  describe "routing" do

    it "routes to #index" do
      get("/panel_subscriptions").should route_to("panel_subscriptions#index")
    end

    it "routes to #new" do
      get("/panel_subscriptions/new").should route_to("panel_subscriptions#new")
    end

    it "routes to #show" do
      get("/panel_subscriptions/1").should route_to("panel_subscriptions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/panel_subscriptions/1/edit").should route_to("panel_subscriptions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/panel_subscriptions").should route_to("panel_subscriptions#create")
    end

    it "routes to #update" do
      put("/panel_subscriptions/1").should route_to("panel_subscriptions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/panel_subscriptions/1").should route_to("panel_subscriptions#destroy", :id => "1")
    end

  end
end
