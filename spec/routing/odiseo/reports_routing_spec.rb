require "spec_helper"

describe Odiseo::ReportsController do
  describe "routing" do

    it "routes to #index" do
      get("/odiseo/reports").should route_to("odiseo/reports#index")
    end

    it "routes to #new" do
      get("/odiseo/reports/new").should route_to("odiseo/reports#new")
    end

    it "routes to #show" do
      get("/odiseo/reports/1").should route_to("odiseo/reports#show", :id => "1")
    end

    it "routes to #edit" do
      get("/odiseo/reports/1/edit").should route_to("odiseo/reports#edit", :id => "1")
    end

    it "routes to #create" do
      post("/odiseo/reports").should route_to("odiseo/reports#create")
    end

    it "routes to #update" do
      put("/odiseo/reports/1").should route_to("odiseo/reports#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/odiseo/reports/1").should route_to("odiseo/reports#destroy", :id => "1")
    end

  end
end
