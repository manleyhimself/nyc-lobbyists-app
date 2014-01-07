require 'spec_helper'

describe LobbyistAction do
  before do
    4.times do |x|
      Lobbyist.create(name: "#{x}L", firm_id: 1)
      Client.create(name: "#{x}L")
      Agency.create(name: "#{x}L")
      Firm.create(name: "#{x}L")
    end
    3.times do |x|
      Action.create(client_id: (x+1), payment: 500)
      LobbyistAction.create(lobbyist_id: 1, action_id: (x+1))
      LobbyistAction.create(lobbyist_id: (x+2), action_id: (1))
      AgencyAction.create(agency_id: 1, action_id: (x+1))
      AgencyAction.create(agency_id: (x+2), action_id: (1))
    end
    @lobbyist = Lobbyist.find(1)
    @action = Action.find(1)
    @agency = Agency.find(1)
    @client = Client.find(1)
    @firm = Firm.find(1)
  end

  context "when LobbyistAction associations have been properly made" do

    it "should have 3 actions" do
      expect(@lobbyist.actions.length).to eq(3)
    end

    it "should have the proper first action" do
      expect(@lobbyist.actions.first.id).to eq(1)
    end

    it "should have the proper last action" do
      expect(@lobbyist.actions.last.id).to eq(3)
    end

    it "should have 4 actions" do
      expect(@action.lobbyists.length).to eq(4)
    end

    it "should have the proper first action" do
      expect(@action.lobbyists.first.id).to eq(1)
    end

    it "should have the proper last action" do
      expect(@action.lobbyists.last.id).to eq(4)
    end
  end

   context "when AgencyAction associations have been properly made" do

    it "should have 3 actions" do
      expect(@agency.actions.length).to eq(3)
    end

    it "should have the proper first action" do
      expect(@agency.actions.first.id).to eq(1)
    end

    it "should have the proper last action" do
      expect(@agency.actions.last.id).to eq(3)
    end

    it "should have 4 agencies" do
      expect(@action.agencies.length).to eq(4)
    end

    it "should have the proper first agency" do
      expect(@action.agencies.first.id).to eq(1)
    end

    it "should have the proper last agency" do
      expect(@action.agencies.last.id).to eq(4)
    end
  end

  context "when all Lobbyist associations have been properly made" do

    it "should have the proper number of agencies" do
      AgencyAction.create(agency_id: 1, action_id: 2)
      @lobbyist = Lobbyist.find(1)
      expect(@lobbyist.agencies.uniq.length).to eq(4)
    end

    it "should have the proper number of clients when a new action with an existing client is added" do
      Action.create(client_id: 1)
      LobbyistAction.create(lobbyist_id: 1, action_id: 4)
      @lobbyist = Lobbyist.find(1)
      expect(@lobbyist.clients.uniq.length).to eq(3)
    end

    it "should have the proper number of actions when a new action with an existing client is added" do
      Action.create(client_id: 1)
      LobbyistAction.create(lobbyist_id: 1, action_id: 4)
      @lobbyist = Lobbyist.find(1)
      expect(@lobbyist.actions.length).to eq(4)
    end

    it "should have the proper number of clients when a new action with a new client is added" do
      Action.create(client_id: 4)
      LobbyistAction.create(lobbyist_id: 1, action_id: 4)
      @lobbyist = Lobbyist.find(1)
      expect(@lobbyist.clients.uniq.length).to eq(4)
    end

    context "when all Agency associations have been properly made" do

      it "should have the proper number of lobbyists" do
        expect(@agency.lobbyists.uniq.length).to eq(4)
      end

      it "should have the proper number of clients when a new action with an existing client is added" do
        Action.create(client_id: 1)
        AgencyAction.create(agency_id: 1, action_id: 4)
        @agency = Agency.find(1)
        expect(@agency.clients.uniq.length).to eq(3)
      end

      it "should have the proper number of actions when a new action with an existing client is added" do
        Action.create(client_id: 1)
        AgencyAction.create(agency_id: 1, action_id: 4)
        @agency = Agency.find(1)
        expect(@agency.actions.length).to eq(4)
      end

      it "should have the proper number of clients when a new action with a new client is added" do
        Action.create(client_id: 4)
        AgencyAction.create(agency_id: 1, action_id: 4)
        @agency = Agency.find(1)
        expect(@agency.clients.length).to eq(4)
      end
    end

    context "when all Client associations have been properly made" do

      it "should have the proper number of lobbyists" do
        expect(@client.lobbyists.uniq.length).to eq(4)
      end

      it "should have the proper number of agencies when a new action is added" do
        Action.create(client_id: 1)
        Agency.create(name: "crazy town")
        AgencyAction.create(agency_id: 5, action_id: 4)
        @client = Client.find(1)
        expect(@client.agencies.uniq.length).to eq(5)
      end
    end
     context "when all Firm associations have been properly made" do

      it "should have the proper number of lobbyists" do
        expect(@firm.lobbyists.uniq.length).to eq(4)
      end

      it "should have the proper amount of clients" do
        expect(@firm.find_clients_and_payments.keys.length).to eq(3) 
      end

      it "should have the proper amount of clients" do
        Client.create(name: "new guy")
        Action.create(client_id: 5, payment: 5)
        LobbyistAction.create(action_id: 4, lobbyist_id: 1)
        expect(@firm.find_clients_and_payments.keys.length).to eq(4) 
      end
    end
  end
end
