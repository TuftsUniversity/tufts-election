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
    end
  end

  before(:each) do
    allow(model_instance).to receive(:blacklight_config).and_return(Blacklight::Configuration.new)
  end

  describe "#list_elections" do
    subject do
      params[:id] = 'AJ0156'
      model_instance.list_elections
    end

    it {
      is_expected.to eq(
      '<ul><li><a href="/catalog/4j03d0249/track">New Jersey 1792 Sheriff, Hunterdon County</a></li><li><a href="/catalog/vt150j84n/track">New Jersey 1793 Sheriff, Hunterdon County</a></li></ul>'
    )
    }
    it { is_expected.to be_html_safe }
  end
end
