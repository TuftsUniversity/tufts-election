require 'spec_helper'

describe CandidateHelper do
  before { skip("Waiting for migration to finalize") }
  before(:each) do
    allow(helper).to receive(:blacklight_config).and_return(Blacklight::Configuration.new)
  end

  describe "#list_elections" do
    subject {
      params[:id] = 'AJ0156'
      helper.list_elections
    }

    it { is_expected.to eq(
      '<ul><li><a href="/catalog/tufts:nj.sheriff.hunterdon.1792/track">New Jersey 1792 Sheriff, Hunterdon County</a></li><li><a href="/catalog/tufts:nj.sheriff.hunterdon.1793/track">New Jersey 1793 Sheriff, Hunterdon County</a></li></ul>'
    )}
    it { is_expected.to be_html_safe }
  end

end
