# frozen_string_literal: true
module ModelNameHelper
  # map_model_name() is called from modified copy of lib/active_fedora/model.rb's classname_from_uri() and to_class_uri();
  # classname_from_uri() is called when the fedora objects are being indexed.  to_class_uri() doesn't
  # actually appear to be called from anywhere.
  # map_model_name() is also called from modified copy of app/helpers/hydra/blacklight_helper_behavior.rb's
  # document_partial_name() to fix the link to the object from the search results page.
  # map_model_name() is also called from modified copy of app/helpers/hydra/hydra_assets_helper_behavior.rb's
  # document_type() to fix the document type displayed on the search results page.
  # map_model_names() is called from app/controllers/file_assets_controller.rb.

  def self.map_model_name(model_name)
    map = { "info:fedora/cm:Audio" => "info:fedora/afmodel:TuftsAudio",
            "info:fedora/cm:Audio.OralHistory" => "info:fedora/afmodel:TuftsAudioText",
            "info:fedora/cm:Image.3DS" => "info:fedora/afmodel:TuftsImage",
            "info:fedora/cm:Image.4DS" => "info:fedora/afmodel:TuftsImage",
            "info:fedora/cm:Image.HTML" => "info:fedora/afmodel:TuftsImageText",
            "info:fedora/cm:WP" => "info:fedora/afmodel:TuftsWP",
            "info:fedora/cm:Text.FacPub" => "info:fedora/afmodel:TuftsFacultyPublication",
            "info:fedora/cm:Text.PDF" => "info:fedora/afmodel:TuftsPdf",
            "info:fedora/cm:Object.Generic" => "info:fedora/afmodel:TuftsGenericObject",
            "info:fedora/cm:Text.EAD" => "info:fedora/afmodel:TuftsEAD",
            "info:fedora/cm:Text.TEI-Fragmented" => "info:fedora/afmodel:TuftsTeiFragmented",
            "info:fedora/cm:Text.TEI" => "info:fedora/afmodel:TuftsTEI",
            "info:fedora/cm:Text.RCR" => "info:fedora/afmodel:TuftsRCR",
            "info:fedora/cm:VotingRecord" => "info:fedora/afmodel:TuftsVotingRecord" }
    result = map[model_name].nil? ? model_name : map[model_name]

    Rails.logger.debug { "map_model_name() has mapped #{model_name} to #{result}" } if result != model_name

    result
  end

  # iterate through an array of model names and call map_model_name() for each element
  def self.map_model_names(model_names)
    mapped_model_names = []

    model_names.each do |model_name|
      mapped_model_names << map_model_name(model_name)
    end

    mapped_model_names
  end
end
