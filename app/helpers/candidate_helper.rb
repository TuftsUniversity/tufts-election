module CandidateHelper
  def list_elections 
    docs = Blacklight.solr.get('select', :params=>{:q=>"candidate_id_s:#{params[:id]} AND format:\"Election Record\"", :fl=>'title_display id'})['response']['docs']
    content_tag(:ul) do
      docs.collect { |election|
        concat(content_tag(:li, link_to(election['title_display'].first, catalog_path(election['id']))))
      }
    end
  end
end
