require 'spec_helper'

describe TuftsVotingRecord do
  describe "an instance" do
    subject { TuftsVotingRecord.new }
    its(:RECORD_XML) { should be_kind_of Datastreams::ElectionRecord}
    its(:DCA_META) { should be_kind_of Datastreams::TuftsDcaMeta}
  end
  describe "to_solr" do
    before do
      @record = TuftsVotingRecord.find("tufts:2")
      @solr_doc = @record.to_solr
    end
    it "should index the correct fields" do
      @solr_doc["voting_record_xml_display"].should == @record.datastreams["RECORD-XML"].to_xml
    end
  end
end
