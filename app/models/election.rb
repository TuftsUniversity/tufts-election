class Election < ActiveFedora::Base
  has_metadata :name => "RECORD-XML", :type => Datastreams::ElectionRecord

end
