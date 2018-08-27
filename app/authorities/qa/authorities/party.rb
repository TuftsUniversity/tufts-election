# frozen_string_literal: true

module Qa::Authorities
  class Party < Qa::Authorities::Base
    ##
    # Returns the Office name, or id if it can't find the name.
    #
    # @params {str} id
    #   The office id.
    def search(id)
      party = ::Party.find(id)
      party.blank? ? id : party.name
    end
  end
end
