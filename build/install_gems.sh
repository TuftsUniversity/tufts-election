#!/bin/sh

if [ "${RAILS_ENV}" = 'production' ] || [ "${RAILS_ENV}" = 'staging' ]; then
  echo "Bundle install without development or test gems."
  bundle config set without 'development'
  bundle config set without 'test'
  bundle install
else
  bundle config set without 'production'
  bundle install
fi
