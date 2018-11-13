# frozen_string_literal: true
class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior
  include BlacklightRangeLimit::RangeLimitBuilder


  self.default_processor_chain += [:exclude_unwanted_models, :exclude_drafts]

  # This filters out objects that you want to exclude from search results.  By default it only excludes FileAssets
  # @param solr_parameters the current solr parameters
  # @param user_parameters the current user-subitted parameters
  def exclude_unwanted_models(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "has_model_ssim:\"VotingRecord\" OR format_ssim:Candidate"
  end

  def exclude_drafts(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "-id:draft*"
  end
end
