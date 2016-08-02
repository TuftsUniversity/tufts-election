require 'rails_helper'

describe TuftsVotingRecord do
  subject {
    record = TuftsVotingRecord.new
    rec_file = File.new(File.join(fixture_path, 'election_records', 'al_staterepresentative_madisoncounty_1820_RECORD-XML.xml'))
    record.datastreams['RECORD-XML'].content = rec_file.read
    record
  }

  describe '#to_solr' do
    let(:solr) { subject.to_solr }

    it 'indexes office' do
      expect(solr['office_id_ssim']).to eq ['ON064']
      expect(solr['office_name_sim']).to eq ['House of Representatives']
      expect(solr['office_name_tesim']).to eq ['House of Representatives']
    end
  end
end
