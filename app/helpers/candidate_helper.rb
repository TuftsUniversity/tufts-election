module CandidateHelper
  def list_elections 
    docs = Blacklight.solr.get('select', :params=>{:q=>"(candidate_id_ssim:#{params[:id]} OR elector_id_ssim:#{params[:id]}) AND format_ssim:\"Election Record\"", :fl=>'title_tesi id', :per_page=>'1000'})['response']['docs']
    content_tag(:ul) do
      docs.collect { |election|
        concat(content_tag(:li, link_to(election['title_tesi'], catalog_path(election['id']))))
      }
    end
  end
end
