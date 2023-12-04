# frozen_string_literal: true
require 'rails_helper'

describe CandidateHelper do
  # Create a mock model to include the concern for testing purposes
  subject(:model_instance) { test_model.new(params) }

  let(:test_model) do
    Class.new do
      include CandidateHelper
      include Blacklight::Searchable

      attr_accessor :params
      def initialize(params = {})
        @params = params
      end

      def search_state
        @search_state ||= Blacklight::SearchState.new(params, blacklight_config, self)
      end
    end
  end

  before(:each) do
    allow(model_instance).to receive(:search_service_class).and_return(Blacklight::SearchService)
    allow(model_instance).to receive(:blacklight_config).and_return(Blacklight::Configuration.new)
  end

  describe "#related_elections" do
    it "should find elections" do
      params[:id] = 'AJ0156'
      elections = model_instance.related_elections
      expect(elections.count).to eq(2)
    end
  end
end
