# frozen_string_literal: true
require 'rails_helper'

describe VotingRecordHelper do
  describe "voting_record_xml_to_table" do
    before do
      @src = File.read(fixture("election_records/al_staterepresentative_madisoncounty_1820.xml"))
    end
    subject do
      @text = helper.voting_record_xml_to_html(@src)
      Nokogiri::HTML.parse(@text)
    end
    it "should link to the candidates" do
      expect(subject.xpath('//tr[@class="candidate-row"]/th/a/@href').first.value).to eq(catalog_path("VJ0000"))
    end
  end
end
