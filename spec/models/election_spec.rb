require 'spec_helper'

describe TuftsVotingRecord do
  describe "an instance" do
    subject { TuftsVotingRecord.new }
    its(:RECORD_XML) { should be_kind_of Datastreams::ElectionRecord}
    its(:DCA_META) { should be_kind_of Datastreams::DublinCore}
  end
end
