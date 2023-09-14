# frozen_string_literal: true

module CandidateHelper
  # instantiate helper in a class
  include Blacklight::Searchable
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include Rails.application.routes.url_helpers
  include Rails.application.routes.url_helpers

  def list_elections
    self.params = {
      qt: "standard",
      q: "(candidate_id_ssim:#{params[:id]} OR elector_id_ssim:#{params[:id]}) AND format_ssim:\"Election Record\"",
      fq: '-id:draft*',
      fl: 'title_ssi id',
      rows: '1000',
      sort: 'title_ssi asc'
    }
    docs = search_service.search_results[1]
    html = String.new
    docs.collect do |election|
      include Rails.application.routes.url_helpers
      link = catalog_path(election['id'])
      link_text = link_to(election['title_ssi'], link)
      html.concat(content_tag(:li, link_text))
    end

    #safe_join(["<ul>", html, "</ul>"])
    ("<ul>" + html + "</ul>").html_safe
  end
end
