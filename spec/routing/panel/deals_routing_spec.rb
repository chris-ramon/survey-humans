require "spec_helper"

describe Panel::DealsController do
  describe "routing" do

    it "routes to #index" do
      get("/panel_deals").should route_to("panel_deals#index")
    end

    it "routes to #new" do
      get("/panel_deals/new").should route_to("panel_deals#new")
    end

    it "routes to #show" do
      get("/panel_deals/1").should route_to("panel_deals#show", :id => "1")
    end

    it "routes to #edit" do
      get("/panel_deals/1/edit").should route_to("panel_deals#edit", :id => "1")
    end

    it "routes to #create" do
      post("/panel_deals").should route_to("panel_deals#create")
    end

    it "routes to #update" do
      put("/panel_deals/1").should route_to("panel_deals#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/panel_deals/1").should route_to("panel_deals#destroy", :id => "1")
    end

  end
end
