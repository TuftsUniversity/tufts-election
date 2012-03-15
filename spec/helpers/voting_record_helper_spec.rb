require 'spec_helper'

describe VotingRecordHelper do
  describe "voting_record_xml_to_table" do
    it "should transform the voting record into html" do
      src = File.read(fixture("election_records/us_potus_1792_RECORD-XML.xml"))
      helper.voting_record_xml_to_table(src).should match "^<div id=\"electionTitle\">"
    end
  end
end
