require "spec_helper"

describe Panel::FeaturesController do
  describe "routing" do

    it "routes to #index" do
      get("/panel_features").should route_to("panel_features#index")
    end

    it "routes to #new" do
      get("/panel_features/new").should route_to("panel_features#new")
    end

    it "routes to #show" do
      get("/panel_features/1").should route_to("panel_features#show", :id => "1")
    end

    it "routes to #edit" do
      get("/panel_features/1/edit").should route_to("panel_features#edit", :id => "1")
    end

    it "routes to #create" do
      post("/panel_features").should route_to("panel_features#create")
    end

    it "routes to #update" do
      put("/panel_features/1").should route_to("panel_features#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/panel_features/1").should route_to("panel_features#destroy", :id => "1")
    end

  end
end
