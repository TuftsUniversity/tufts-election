require 'spec_helper'

describe CandidateHelper do

  describe "#list_elections" do
    subject {
      Blacklight.solr.should_receive(:get).with('select', :params=>{:q=>'candidate_id_s:AA00005 AND format:"Election Record"', :fl=>'title_display id'})
        .and_return({'response'=>{'docs'=>[{'id'=>'one', 'title_display'=>['first']}, {'id'=>'two', 'title_display'=>['second']}]}})
      params[:id] = 'AA00005'
      helper.list_elections
    }

    it { should == '<ul><li><a href="/catalog/one">first</a></li><li><a href="/catalog/two">second</a></li></ul>'}
    it { should be_html_safe}
  end


end
