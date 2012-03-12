require 'spec_helper'

describe Election do
  describe "an instance" do
    subject { Election.new }
    its(:RECORD_XML) { should be_kind_of Datastreams::ElectionRecord}
  end
end
