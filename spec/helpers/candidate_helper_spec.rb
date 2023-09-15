# frozen_string_literal: true
require 'rails_helper'

describe CandidateHelper do
  let(:test_model) do
    # Create a dummy controller instance
    controller = CandidatesController.new
    controller.extend(CandidateHelper)
    controller.extend(ActionView::Helpers::TagHelper)
    controller.extend(ActionView::Helpers::UrlHelper)
    controller.extend(Blacklight::Searchable)

    # Mock necessary methods and attributes
    allow(controller).to receive(:blacklight_config).and_return(Blacklight::Configuration.new)
    controller.params = {id: 'AJ0156'} # Set params to an empty hash or provide relevant params

    controller
  end

  describe "#list_elections" do
    subject do
      params[:id] = 'AJ0156'
      test_model.list_elections
    end

    it {
      is_expected.to eq(
        '<ul><li><a href="/catalog/4j03d0249/track">New Jersey 1792 Sheriff, Hunterdon County</a></li><li><a href="/catalog/vt150j84n/track">New Jersey 1793 Sheriff, Hunterdon County</a></li></ul>'
      )
    }

    it { is_expected.to be_html_safe }
  end
end