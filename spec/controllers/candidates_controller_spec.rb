# frozen_string_literal: true
require 'rails_helper'

describe CandidatesController, api: true do
  it "should have index" do
    get :index, params: { candidate_last_name_letter: 'A' }
    expect(response).to be_success
    #expect(response.body).to eq " "
  end

  # describe "#list_elections" do
  #   subject do
  #     params[:id] = 'AJ0156'
  #     described_class.list_elections
  #   end

  #   it {
  #     is_expected.to eq(
  #     '<ul><li><a href="/catalog/4j03d0249/track">New Jersey 1792 Sheriff, Hunterdon County</a></li><li><a href="/catalog/vt150j84n/track">New Jersey 1793 Sheriff, Hunterdon County</a></li></ul>'
  #   )
  #   }
  #   it { is_expected.to be_html_safe }
  # # end
  # describe "#show" do
  #   it "renders the list of elections" do
  #     params = { id: 'AJ0156' }
      
  #     get :show, params: params

  #     # Assuming that the controller action sets up the elections_list instance variable
  #     expect(assigns(:elections_list)).to eq(
  #       '<ul><li><a href="/catalog/4j03d0249/track">New Jersey 1792 Sheriff, Hunterdon County</a></li><li><a href="/catalog/vt150j84n/track">New Jersey 1793 Sheriff, Hunterdon County</a></li></ul>'
  #     )
  #   end
  # end
  # #Grabed test from blacklight should work
  # describe "show action" do
  #   describe "with format :html" do
  #     it "gets document", integration: true do
  #       get :show, params: { id: 'AJ0156' }
  #       expect(response).to be_successful
  #     end
  #   end
  # end
end


