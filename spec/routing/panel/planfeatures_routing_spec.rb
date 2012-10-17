require "spec_helper"

describe Panel::PlanfeaturesController do
  describe "routing" do

    it "routes to #index" do
      get("/panel_planfeatures").should route_to("panel_planfeatures#index")
    end

    it "routes to #new" do
      get("/panel_planfeatures/new").should route_to("panel_planfeatures#new")
    end

    it "routes to #show" do
      get("/panel_planfeatures/1").should route_to("panel_planfeatures#show", :id => "1")
    end

    it "routes to #edit" do
      get("/panel_planfeatures/1/edit").should route_to("panel_planfeatures#edit", :id => "1")
    end

    it "routes to #create" do
      post("/panel_planfeatures").should route_to("panel_planfeatures#create")
    end

    it "routes to #update" do
      put("/panel_planfeatures/1").should route_to("panel_planfeatures#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/panel_planfeatures/1").should route_to("panel_planfeatures#destroy", :id => "1")
    end

  end
end
