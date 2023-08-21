# frozen_string_literal: true
require 'rails_helper'

describe CatalogController, type: :controller do
  describe "GET /show" do
    it 'enforces random as id' do
      get :show, params: { id: "1" }
      expect(response).not_to be_success
    end

    it 'does not show draft objects' do
      get :show, params: { id: "draft_book" }
      expect(response.status).to be(302)
    end
  end
end
