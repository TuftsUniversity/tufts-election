# frozen_string_literal: true
module BlacklightHelper
  include Blacklight::BlacklightHelperBehavior
  # Override: In cases where document_heading is an array, use the first value
  def document_heading
    heading = @document[blacklight_config.show.heading] || @document.id
    if heading.is_a?(Array)
      heading.first
    else
      heading
    end
  end
end
