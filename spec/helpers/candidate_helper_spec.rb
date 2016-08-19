require 'spec_helper'

describe CandidateHelper do
  describe "#list_elections" do
    subject {
      #expect(Blacklight.solr).to receive(:get).with('select', :params=>{:q=>'(candidate_id_ssim:AA00005 OR elector_id_ssim:AA00005) AND format_ssim:"Election Record"', :fl=>'title_tesi id', :fq=>"-id:draft*", :rows=>"1000", :sort=>"title_ssi asc"})
      #.and_return({'response'=>{'docs'=>[{'id'=>'one', 'title_tesi'=>'first'}, {'id'=>'two', 'title_tesi'=>'second'}]}})
      params[:id] = 'AA00005'
      helper.list_elections
    }

    it { is_expected.to eq('<ul><li><a href="/catalog/one/track">first</a></li><li><a href="/catalog/two/track">second</a></li></ul>')}
    it { is_expected.to be_html_safe}
  end


end
