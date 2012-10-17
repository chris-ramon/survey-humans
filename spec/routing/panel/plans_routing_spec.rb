require "spec_helper"

describe Panel::PlansController do
  describe "routing" do

    it "routes to #index" do
      get("/panel_plans").should route_to("panel_plans#index")
    end

    it "routes to #new" do
      get("/panel_plans/new").should route_to("panel_plans#new")
    end

    it "routes to #show" do
      get("/panel_plans/1").should route_to("panel_plans#show", :id => "1")
    end

    it "routes to #edit" do
      get("/panel_plans/1/edit").should route_to("panel_plans#edit", :id => "1")
    end

    it "routes to #create" do
      post("/panel_plans").should route_to("panel_plans#create")
    end

    it "routes to #update" do
      put("/panel_plans/1").should route_to("panel_plans#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/panel_plans/1").should route_to("panel_plans#destroy", :id => "1")
    end

  end
end
