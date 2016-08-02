require 'rails_helper'

describe CandidatesController do

  it "should have index" do
    get :index, :candidate_last_name_letter=>'A'
    expect(response).to be_success
  end

end
