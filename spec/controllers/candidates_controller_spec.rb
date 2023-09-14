# frozen_string_literal: true
require 'rails_helper'

describe CandidatesController, api: true do
  render_views

  # TODO: need to solve why a sucess
  it "should have index" do
    get :index, params: { candidate_last_name_letter: 'A' }
    expect(response.status).to be(200)
    expect(response).to be_successful
  end
  it "should have index no params" do
    get :index
    expect(response.status).to be(200)
    expect(response).to be_successful
  end
end
