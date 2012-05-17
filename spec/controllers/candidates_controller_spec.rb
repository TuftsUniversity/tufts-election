require 'spec_helper'

describe CandidatesController do

  it "should have index" do
    get :index, :candidate_last_name_letter=>'A'
    response.should be_success
  end

end
