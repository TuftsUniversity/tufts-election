# frozen_string_literal: true
require 'rails_helper'

describe CatalogController, type: :controller do
  describe "GET /show" do
    it 'enforces random as id' do
      get :show, params: { id: "HFS123" }
      expect(response).to_not be_successful
      expect(response.status).to be(404)
    end

    it 'does not show draft objects' do
      get :show, params: { id: "draft_book" }
      expect(response.status).to be(302)
    end
  end

  describe "GET /index" do
    it 'basic index' do
      get :index
      expect(response).to be_successful
    end
  end
end
