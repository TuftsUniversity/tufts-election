require 'spec_helper'

describe Election do
  describe "an instance" do
    subject { Election.new }
    its(:RECORD_XML) { should be_kind_of Datastreams::ElectionRecord}
    its(:DCA_META) { should be_kind_of Datastreams::DublinCore}
  end
end
