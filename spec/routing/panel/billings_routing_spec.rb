require "spec_helper"

describe Panel::BillingsController do
  describe "routing" do

    it "routes to #index" do
      get("/panel_billings").should route_to("panel_billings#index")
    end

    it "routes to #new" do
      get("/panel_billings/new").should route_to("panel_billings#new")
    end

    it "routes to #show" do
      get("/panel_billings/1").should route_to("panel_billings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/panel_billings/1/edit").should route_to("panel_billings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/panel_billings").should route_to("panel_billings#create")
    end

    it "routes to #update" do
      put("/panel_billings/1").should route_to("panel_billings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/panel_billings/1").should route_to("panel_billings#destroy", :id => "1")
    end

  end
end
