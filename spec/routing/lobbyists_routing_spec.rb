require "spec_helper"

describe LobbyistsController do
  describe "routing" do

    it "routes to #index" do
      get("/lobbyists").should route_to("lobbyists#index")
    end

    it "routes to #new" do
      get("/lobbyists/new").should route_to("lobbyists#new")
    end

    it "routes to #show" do
      get("/lobbyists/1").should route_to("lobbyists#show", :id => "1")
    end

    it "routes to #edit" do
      get("/lobbyists/1/edit").should route_to("lobbyists#edit", :id => "1")
    end

    it "routes to #create" do
      post("/lobbyists").should route_to("lobbyists#create")
    end

    it "routes to #update" do
      put("/lobbyists/1").should route_to("lobbyists#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/lobbyists/1").should route_to("lobbyists#destroy", :id => "1")
    end

  end
end
