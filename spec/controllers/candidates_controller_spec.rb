# frozen_string_literal: true
require 'rails_helper'

describe CandidatesController do
  it "should have index" do
    get :index, params: { candidate_last_name_letter: 'A' }
    expect(response).to be_success
  end

  describe "#list_elections" do
    subject do
      params[:id] = 'AJ0156'
      model_instance.controller.list_elections
    end

    it {
      is_expected.to eq(
      '<ul><li><a href="/catalog/4j03d0249/track">New Jersey 1792 Sheriff, Hunterdon County</a></li><li><a href="/catalog/vt150j84n/track">New Jersey 1793 Sheriff, Hunterdon County</a></li></ul>'
    )
    }
    it { is_expected.to be_html_safe }
  end
end


