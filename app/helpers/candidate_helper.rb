module CandidateHelper
  include Blacklight::SearchHelper

  def list_elections
    docs = search_results({:q=>"(candidate_id_ssim:#{params[:id]} OR elector_id_ssim:#{params[:id]}) AND format_ssim:\"Election Record\"",:fq=>'-id:draft*',:fl=>'title_tesi id', :rows=>'1000',:sort=>'title_ssi asc'})[1]
    content_tag(:ul) do
      docs.collect { |election|
        concat(content_tag(:li, link_to(election['title_tesi'], catalog_path(election['id']))))
      }
    end
  end
end
