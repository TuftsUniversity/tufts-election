# frozen_string_literal: true
class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior

  # This filters out objects that you want to exclude from search results, like FileAssets
  self.default_processor_chain += [:exclude_unwanted_models, :exclude_drafts]


  def exclude_unwanted_models(solr_parameters, user_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "has_model_ssim:\"info:fedora/cm:VotingRecord\" OR format_ssim:Candidate"
  end

  def exclude_drafts(solr_parameters,user_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << "-id:draft*"
  end
end
