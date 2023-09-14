# frozen_string_literal: true
TuftsElection::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Do not compress assets
  config.assets.compress = true
  # config.assets.precompile += %w( *.css *.erb *.scss *.js *.coffee *.png *.jpg *.ico *.gif)

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Rails.application.config.middleware.use(
  #   ExceptionNotification::Rack,
  #   # Blacklight uses its own 404 extension we need to ignore separately
  #   ignore_exceptions: ['Blacklight::Exceptions::RecordNotFound'] + ExceptionNotifier.ignored_exceptions)
  # end

  # temp while debug ui
  config.assets.compress = false
  config.assets.debug = true
  config.assets.concat = false
end
