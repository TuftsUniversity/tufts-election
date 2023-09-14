# frozen_string_literal: true

module CandidateHelper
  def related_elections
    new_search_service = search_service_class.new(config: blacklight_config, user_params: {
                                                    qt: "standard",
                                                    q: "(candidate_id_ssim:#{params[:id]} OR elector_id_ssim:#{params[:id]}) AND format_ssim:\"Election Record\"",
                                                    fl: 'title_ssi id',
                                                    rows: '1000',
                                                    sort: 'title_ssi asc'
                                                  },
                                                  **search_service_context)

    docs = new_search_service.search_results[1]

    docs.collect
  end
end
