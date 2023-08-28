# frozen_string_literal: true

module CandidateHelper
  # instantiate helper in a class
  include Blacklight::Searchable
  def list_elections
    # puts(Blacklight::Searchable.methods)
    # class_attribute :search_service_class
    # self.search_service_class = Blacklight::SearchService
    # Blacklight::Searchable.
    #puts (search_service_class.to_s)
    puts (search_service)
    docs = search_service.search_results({
                                           qt: "standard",
                                           q: "(candidate_id_ssim:#{params[:id]} OR elector_id_ssim:#{params[:id]}) AND format_ssim:\"Election Record\"",
                                           fq: '-id:draft*',
                                           fl: 'title_ssi id',
                                           rows: '1000',
                                           sort: 'title_ssi asc'
                                         })[1]
    content_tag(:ul) do
      docs.collect do |election|
        concat(content_tag(:li, link_to(election['title_ssi'], catalog_path(election['id']))))
      end
    end
  end
end
