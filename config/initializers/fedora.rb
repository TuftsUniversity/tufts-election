
# Set our ActiveFedora to resolve URIs the same as MIRA
ActiveFedora::Base.translate_id_to_uri = ActiveFedora::Noid.config.translate_id_to_uri
ActiveFedora::Base.translate_uri_to_id = ActiveFedora::Noid.config.translate_uri_to_id

