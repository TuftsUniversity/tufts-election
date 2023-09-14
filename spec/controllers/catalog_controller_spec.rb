# frozen_string_literal: true
require 'rails_helper'

describe CatalogController, type: :controller do
  describe "GET /show" do
    it 'enforces random as id' do
      get :show, params: { id: "HFS123" }
      expect(response).to_not be_successful
      expect(response.status).to be(404)
    end

    # I would like to add this test, but need to find an id that won't 404
    # it 'shows an item' do
    #   get :show, params: { id: 'AJ0156' }
    #   expect(response.status).to be(200)
    #   expect(response).to be_successful
    # end

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
