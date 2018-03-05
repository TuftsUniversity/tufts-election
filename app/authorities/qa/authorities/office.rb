# frozen_string_literal: true

module Qa::Authorities
  class Office < Qa::Authorities::Base
    ##
    # Returns the Office name, or id if it can't find the name.
    #
    # @params {str} id
    #   The office id.
    def search(id)
      office = ::Office.find(id)
      office.blank? ? id : office.name
    end
  end
end
