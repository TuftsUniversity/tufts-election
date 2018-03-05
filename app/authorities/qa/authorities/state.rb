# frozen_string_literal: true

module Qa::Authorities
  class State < Qa::Authorities::Base
    ##
    # Returns the Office name, or id if it can't find the name.
    #
    # @params {str} id
    #   The office id.
    def search(name)
      state = ::State.find(name)
      state.blank? ? name : state.name
    end
  end
end
