# frozen_string_literal: true
require 'rails_helper'

describe CatalogController, type: :controller do

  describe "GET /show" do
    it 'enforces random as id' do
      get :show, params: { id: "1" }
      expect(response).not_to be_successful
    end

    it 'does not show draft objects' do
      get :show, params: { id: "draft_book" }
      expect(response.status).to be(302)
    end
  end

  describe "#show" do
    render_views
    it "renders the list of elections" do
      puts "test"
      params = { id: 'AJ0156' }
      
      get :show, params: params

      expect(response).to be_successful
      expect(response.status).to eq 200
      expect(response.no_content?).to be false

      expect(response.message).to eq "OK"

      #expect(response.content_type).to eq "OK"
      #expect(response.parsed_body).to eq "OK"

      #expect(response.class).to eq ""
      #expect(response.methods).to eq ""

      #expect(response).to render_template('catalog/_show_candidate')

      # Assuming that the controller action sets up the elections_list instance variable
      # expect(response.content).to include(
      #   '<ul><li><a href="/catalog/4j03d0249/track">New Jersey 1792 Sheriff, Hunterdon County</a></li><li><a href="/catalog/vt150j84n/track">New Jersey 1793 Sheriff, Hunterdon County</a></li></ul>'
      # )
      expect(response.body).to include("New Jersey 1792 Sheriff")
    end
    it "index test" do
      get :index
      expect(response.body).to eq ""
    end
  end
end
