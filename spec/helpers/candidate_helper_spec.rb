# frozen_string_literal: true
require 'rails_helper'
include Blacklight::Searchable

describe CandidateHelper do
  # Create a mock model to include the concern for testing purposes
  subject(:model_instance) { test_model.new(params) }

  let(:test_model) do
    Class.new do
      controller = CandidatesController.new
      controller.extend(CandidateHelper)
      controller.extend(ActionView::Helpers::TagHelper)
      controller.extend(ActionView::Helpers::UrlHelper)
      controller.extend(Blacklight::Searchable)

      class_attribute :search_service_class

      attr_accessor :params
      def initialize(params = {})
        @params = params

        #link = catalog_path("4j03d0249")

        self.controller.search_service_class = Blacklight::SearchService
      end

      def search_state
        @search_state ||= Blacklight::SearchState.new(params, blacklight_config, self)
      end
    end
  end

  before(:each) do
    #allow(model_instance.controller).to receive(:search_service_class).and_return(Blacklight::SearchService)
    search_state = Blacklight::SearchState.new(params, blacklight_config, self)
    allow(model_instance.controller).to receive(:search_state).and_return(search_state)
    allow(model_instance).to receive(:blacklight_config).and_return(Blacklight::Configuration.new)
  end

  describe "#list_elections" do
    subject do
      params[:id] = 'AJ0156'
      model_instance.controller.list_elections
    end

    it {
      is_expected.to eq(
      '<ul><li><a href="/catalog/4j03d0249/track">New Jersey 1792 Sheriff, Hunterdon County</a></li><li><a href="/catalog/vt150j84n/track">New Jersey 1793 Sheriff, Hunterdon County</a></li></ul>'
    )
    }
    it { is_expected.to be_html_safe }
  end
end
